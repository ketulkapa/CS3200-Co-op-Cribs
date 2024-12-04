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

# Create a new Blueprint for events
neighborhoods = Blueprint('events', __name__)

# Retrieve all events
@events.route('/events', methods=['GET'])
def get_all_events():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM events')
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200
    return response