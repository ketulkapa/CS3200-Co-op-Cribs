from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

# Create a new Blueprint for messages
messages = Blueprint('messages', __name__)

# Create a new message (POST)
@messages.route('/messages', methods=['POST'])
def create_message():
    current_app.logger.info('POST /messages route')
    message_info = request.json
    sender_id = message_info['sender_id']
    receiver_id = message_info['receiver_id']
    content = message_info['content']

    query = '''
        INSERT INTO message (sender_id, receiver_id, content, created_at)
        VALUES (%s, %s, %s, NOW())
    '''
    data = (sender_id, receiver_id, content)
    
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    response = make_response(jsonify({'message': 'Message created successfully!'}))
    response.status_code = 201
    return response

# Get messages for a specific user (GET)
@messages.route('/messages/<int:user_id>', methods=['GET'])
def get_messages_for_user(user_id):
    current_app.logger.info(f'GET /messages/{user_id} route')

    query = '''
        SELECT m.message_id, m.sender_id, m.receiver_id, m.content, m.created_at
        FROM message m
        WHERE m.receiver_id = %s OR m.sender_id = %s
        ORDER BY m.created_at DESC
    '''
    
    cursor = db.get_db().cursor()
    cursor.execute(query, (user_id, user_id))
    messages = cursor.fetchall()

    if not messages:
        response = make_response(jsonify({'message': 'No messages found for the user.'}))
        response.status_code = 404
        return response

    response = make_response(jsonify({'messages': messages}))
    response.status_code = 200
    return response

# Update a specific message (PUT)
@messages.route('/messages/<int:message_id>', methods=['PUT'])
def update_message(message_id):
    current_app.logger.info(f'PUT /messages/{message_id} route')
    message_info = request.json
    content = message_info.get('content', None)

    query = '''
        UPDATE message
        SET content = %s
        WHERE message_id = %s
    '''
    data = (content, message_id)
    
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    response = make_response(jsonify({'message': 'Message updated successfully!'}))
    response.status_code = 200
    return response

# Delete a specific message (DELETE)
@messages.route('/messages/<int:message_id>', methods=['DELETE'])
def delete_message(message_id):
    current_app.logger.info(f'DELETE /messages/{message_id} route')

    query = 'DELETE FROM message WHERE message_id = %s'
    cursor = db.get_db().cursor()
    cursor.execute(query, (message_id,))
    db.get_db().commit()

    response = make_response(jsonify({'message': 'Message deleted successfully!'}))
    response.status_code = 200
    return response