########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db
from backend.ml_models.model01 import predict

#------------------------------------------------------------
# Create a new Blueprint object, which is a collection of 
# routes.
reviews = Blueprint('reviews', __name__)

#------------------------------------------------------------

# Get reviews for a specific subletter
@reviews.route('/reviews/<int:reviewee_id>', methods=['GET'])
def get_reviews(reviewee_id):
    cursor = db.get_db().cursor()
    query = '''
        SELECT * FROM reviews WHERE reviewee_id = %s
    '''
    cursor.execute(query, (reviewee_id,))
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200
    return response

# Add a review for a subletter after the sublet period ends
@reviews.route('/reviews', methods=['POST'])
def add_review():
    current_app.logger.info('POST /reviews route')
    review_info = request.json
    rating = review_info['rating']
    reviewer_id = review_info['reviewer_id']
    reviewee_id = review_info['reviewee_id']
    content = review_info['content']
    safety_score = review_info['safety_score']
    
    query = '''
        INSERT INTO reviews (rating, reviewer_id, reviewee_id, date, content, safety_score)
        VALUES (%s, %s, %s, NOW(), %s, %s)
    '''
    data = (rating, reviewer_id, reviewee_id, content, safety_score)
    
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    
    response = make_response(jsonify({'message': 'Review added successfully!'}))
    response.status_code = 201
    return response

