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
        WHERE rm.user1 = %s
        ORDER BY rm.compatability_score DESC
    '''
    
    cursor = db.get_db().cursor(dictionary=True)
    cursor.execute(query, (user_id,))
    matches = cursor.fetchall()

    if not matches:
        response = make_response(jsonify({'message': 'No matches found for the user.'}))
        response.status_code = 404
        return response

    response = make_response(jsonify({'matches': matches}))
    response.status_code = 200
    return response