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

# Creates new user
@users.route('/users', methods=['POST'])
def add_user():
    current_app.logger.info('POST /users route')
    user_info = request.json
    name = user_info['name']
    role = user_info.get('role', None)
    phone_number = user_info.get('phone_number', None)
    first_name = user_info.get('first_name', None)
    last_name = user_info.get('last_name', None)
    email = user_info.get('email', None)
    
    query = '''
        INSERT INTO neighborhoods (name, population_density, safety_travel, insights)
        VALUES (%s, %s, %s, %s)
    '''
    data = (name, population_density, safety_travel, insights)
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    
    response = make_response(jsonify({'message': 'Neighborhood added successfully!'}))
    response.status_code = 201
    return response

# Retrieves all students
@users.route('/users/students', methods=['GET'])
def get_all_students():
    cursor = db.get_db().cursor()
    cursor.execute("SELECT * FROM users WHERE student = 'student'")
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200
    return response