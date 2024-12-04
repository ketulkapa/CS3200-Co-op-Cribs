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
