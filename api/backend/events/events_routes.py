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

# Retrieve events by zipcode
@events.route('/events/<zipcode>', methods=['GET'])
def get_zipcode_event(zipcode):
    cursor = db.get_db().cursor()
    query = 'SELECT * FROM events WHERE zipcode = %s'
    cursor.execute(query, (zipcode,))
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
    zipcode = event_info.get('zipcode')
    description = event_info.get('description', None)
    target_audience = event_info.get('target_audience', None)
    event_host = event_info.get('event_host', None)
    
    query = '''
        INSERT INTO events (name, event_date, loc, zipcode, description, target_audience, event_host)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    '''
    data = (name, event_date, loc, zipcode, description, target_audience, event_host)
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    
    response = make_response(jsonify({'message': 'Event added successfully!'}))
    response.status_code = 201
    return response


# Update an existing event by ID
@events.route('/events/<int:event_id>', methods=['PUT'])
def update_event(event_id):
    current_app.logger.info(f'PUT /events/{event_id} route')
    event_info = request.json
    name = event_info['name']
    event_date = event_info.get('event_date')
    loc = event_info.get('loc')
    zipcode = event_info.get('zipcode')
    description = event_info.get('description', None)
    target_audience = event_info.get('target_audience', None)
    event_host = event_info.get('event_host', None)
    
    query = '''
        UPDATE events
        SET name = %s, event_date = %s, loc = %s, zipcode = %s, description = %s, target_audience = %s, event_host = %s
        WHERE event_id = %s
    '''

    data = (event_id, name, event_date, loc, zipcode, description, target_audience, event_host)
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    response = make_response(jsonify({'message': 'Event updated successfully!'}))
    response.status_code = 200
    return response

# Delete an event by ID
@events.route('/events/<int:event_id>', methods=['DELETE'])
def delete_events(event_id):
    query = 'DELETE FROM events WHERE event_id = %s'
    cursor = db.get_db().cursor()
    cursor.execute(query, (event_id,))
    db.get_db().commit()
    
    response = make_response(jsonify({'message': 'Event deleted successfully!'}))
    response.status_code = 200
    return response