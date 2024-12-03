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

