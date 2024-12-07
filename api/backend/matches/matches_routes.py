from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

# Create a new Blueprint for users
matches = Blueprint('matches', __name__)

@matches.route('/matches/<int:user_id>', methods=['PUT'])
def update_match(user_id):
    current_app.logger.info('PUT /matches/<user_id> route')
    match_info = request.json
    user1 = match_info['user1']
    user2 = match_info['user2']
    compatibility_score = match_info['compatibility_score']
    shared_interests = match_info['shared_interests']

    query = '''
        UPDATE roommateMatches 
        SET user1 = %s, user2 = %s, compatability_score = %s, shared_interests = %s
        WHERE match_id = %s
    '''
    data = (user1, user2, compatibility_score, shared_interests, user_id)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    response = make_response(jsonify({'message': 'Roommate match updated successfully!'}))
    response.status_code = 200
    return response

@matches.route('/matches/<int:user_id>', methods=['DELETE'])
def delete_match(user_id):
    current_app.logger.info('DELETE /matches/<user_id> route')
    
    query = 'DELETE FROM roommateMatches WHERE user_id = %s'
    cursor = db.get_db().cursor()
    cursor.execute(query, (user_id,))
    db.get_db().commit()
    
    response = make_response(jsonify({'message': 'Roommate match deleted successfully!'}))
    response.status_code = 200
    return response

@matches.route('/matches/<int:user_id>', methods=['GET'])
def get_personalized_roommate_matches(user_id):
    current_app.logger.info('GET /matches/<user_id> route')

    query = '''
        SELECT rm.match_id, rm.user2 AS matched_user_id, rm.compatability_score, rm.shared_interests,
               u.first_name, u.last_name, u.budget, u.preferred_location, u.interests
        FROM roommateMatches rm
        JOIN users u ON rm.user2 = u.user_id
        WHERE rm.user2 = %s
        ORDER BY rm.compatability_score DESC
        LIMIT 10
    '''
    
    cursor = db.get_db().cursor()
    cursor.execute(query, (user_id,))
    matches = cursor.fetchall()

    if not matches:
        response = make_response(jsonify({'matches': 'No matches found for the user.'}))
        response.status_code = 404
        return response

    response = make_response(jsonify(matches))
    response.status_code = 200
    return response

@matches.route('/matches/<int:user_id>', methods=['POST'])
def update_all_compatibility_scores():
    current_app.logger.info('Updating all compatibility scores in roommateMatches')

    match_query = '''
        SELECT rm.match_id, rm.user1, rm.user2, 
               u1.budget AS user1_budget, u1.interests AS user1_interests, u1.preferred_location AS user1_location,
               u2.budget AS user2_budget, u2.interests AS user2_interests, u2.preferred_location AS user2_location
        FROM roommateMatches rm
        JOIN users u1 ON rm.user1 = u1.user_id
        JOIN users u2 ON rm.user2 = u2.user_id
    '''
    cursor = db.get_db().cursor()
    cursor.execute(match_query)
    matches = cursor.fetchall()

    update_query = '''
        UPDATE roommateMatches 
        SET compatability_score = %s, shared_interests = %s 
        WHERE match_id = %s
    '''

    for match in matches:
        budget_diff = abs(match['user1_budget'] - match['user2_budget'])
        budget_score = max(0, 100 - budget_diff) 
        
        user1_interests = set(match['user1_interests'].split(', '))
        user2_interests = set(match['user2_interests'].split(', '))
        shared_interests = ', '.join(user1_interests.intersection(user2_interests))
        interest_score = len(user1_interests.intersection(user2_interests)) * 10  

        total_score = budget_score + interest_score

        cursor.execute(update_query, (total_score, shared_interests, match['match_id']))

    db.get_db().commit()

    response = make_response(jsonify({'message': 'Compatibility scores updated successfully!'}))
    response.status_code = 200
    return response
