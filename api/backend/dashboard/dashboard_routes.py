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

# Create a new Blueprint for Dashboard
dashboard = Blueprint('dashboard', __name__)

# Retrieve all dashboard
@dashboard.route('/dashboard', methods=['GET'])
def get_all_dashboard():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM dashboard')
    data = cursor.fetchall()
    response = make_response(jsonify(data))
    response.status_code = 200
    return response

# Get a dashboard by ID
@dashboard.route('dashboard/<int:dashboard_id>', methods=['GET'])
def get_dashboard(dashboard_id):
    cursor = db.get_db().cursor()
    cursor.execute('''
                    SELECT * FROM dashboard WHERE id = {0}
    '''.format(dashboard_id))
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

