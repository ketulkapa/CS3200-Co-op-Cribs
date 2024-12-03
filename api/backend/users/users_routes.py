from flask import Blueprint
from flask import request
from flask import jsonify
from flask import make_response
from flask import current_app
from backend.db_connection import db

# Create a new Blueprint for users
users = Blueprint('users', __name__)

# Retrieves all users
@users.route('/users', methods=['GET'])
def get_all_users():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM users')
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200
    return response