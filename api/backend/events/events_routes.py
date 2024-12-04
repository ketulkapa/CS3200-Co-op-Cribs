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
events = Blueprint('events', __name__)

# Retrieve all events
@events.route('/events', methods=['GET'])
def get_all_events():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM events')
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200
    return response

# Add a new event
@events.route('/events', methods=['POST'])
def add_event():
    current_app.logger.info('POST /events route')
    event_info = request.json
    name = event_info['name']
    event_date = event_info.get('event_date')
    loc = event_info.get('loc')
    insights = event_info.get('description', None)
    target_audience = event_info.get('target_audience', None)
    event_host = event_info.get('event_host', None)
    
    query = '''
        INSERT INTO events (name, event_date, loc, description, target_audience, event_host)
        VALUES (%s, %s, %s, %s, %s, %s)
    '''
    data = (name, event_date, loc, description, target_audience, event_host)
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    
    response = make_response(jsonify({'message': 'Event added successfully!'}))
    response.status_code = 201
    return response