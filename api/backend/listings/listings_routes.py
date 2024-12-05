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
listings = Blueprint('listings', __name__)


#------------------------------------------------------------
# Get all listings
@listings.route('/listings', methods=['GET'])
def get_listings():

    cursor = db.get_db().cursor()
    cursor.execute('''
                    SELECT * FROM listings
    ''')
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

# Add a new listing
@listings.route('/listings', methods=['POST'])
def add_listing():
    current_app.logger.info('PUT /listings route')
    listing_info = request.json
    rent_amount = listing_info['rent_amount']
    title = listing_info['title']
    description = listing_info['description']
    amenities = listing_info['amenities']
    safety_rating = listing_info['safety_rating']
    location = listing_info['location']
    created_by = listing_info['created_by']
    neighborhood_id = listing_info['neighborhood_id']
    house_number = listing_info['house_number']
    street = listing_info['street']
    city = listing_info['city']
    zipcode = listing_info['zipcode']
    verification_status = listing_info['verification_status']
    timeline = listing_info['timeline']

    query = '''
        INSERT INTO listings (rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    '''
    data = (rent_amount, title, description, amenities, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    the_response = make_response(jsonify('listing added!'))
    the_response.status_code = 201

    return the_response

# Get a listing by ID
@listings.route('/listings/<listingID>', methods=['GET'])
def get_listing(listingID):
    cursor = db.get_db().cursor()
    cursor.execute('''
                    SELECT * FROM listings WHERE listing_id = %s
    ''', (listingID,))
    
    theData = cursor.fetchall()
    
    if theData:
        the_response = make_response(jsonify(theData))
        the_response.status_code = 200
    else:
        the_response = make_response(jsonify({'error': 'Listing not found'}))
        the_response.status_code = 404
    
    return the_response

# Update a listing by ID
@listings.route('/listings/<listingID>', methods=['PUT'])
def update_listing(listingID):
    current_app.logger.info('PUT /listings/<listingID> route')
    listing_info = request.json
    rent_amount = listing_info['rent_amount']
    title = listing_info['title']
    description = listing_info['description']
    amenities = listing_info['amenities']
    safety_rating = listing_info['safety_rating']
    location = listing_info['location']
    neighborhood_id = listing_info['neighborhood_id']
    house_number = listing_info['house_number']
    street = listing_info['street']
    city = listing_info['city']
    zipcode = listing_info['zipcode']
    verification_status = listing_info['verification_status']
    timeline = listing_info['timeline']

    query = '''
        UPDATE listings SET rent_amount = %s, title = %s, description = %s, amenities = %s, safety_rating = %s, location = %s, neighborhood_id = %s, house_number = %s, street = %s, city = %s, zipcode = %s, verification_status = %s, timeline = %s
        WHERE listing_id = %s
    '''
    data = (rent_amount, title, description, amenities, safety_rating, location, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline, listingID)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    the_response = make_response(jsonify('listing updated!'))
    the_response.status_code = 200
    return the_response

# Delete a listing by ID
@listings.route('/listings/<listingID>', methods=['DELETE'])
def delete_listing(listingID):
    query = '''
        DELETE FROM listings WHERE listing_id = %s
    '''
    data = (listingID)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    the_response = make_response(jsonify('listing deleted!'))
    the_response.status_code = 200
    return the_response

# Get all listings created in the last 7 days
@listings.route('/listings/new/<end_date>', methods=['GET'])
def get_new_listings(end_date):
    cursor = db.get_db().cursor()
    cursor.execute('''
                   SELECT 
                   rent_amount, 
                   title, 
                   description, 
                   amenities, 
                   match_score, 
                   safety_rating, 
                   location, 
                   created_by, 
                   neighborhood_id, 
                   house_number, 
                   street, 
                   city, 
                   zipcode, 
                   verification_status, 
                   timeline 
                   FROM listings 
                   WHERE created_at BETWEEN %s AND CURRENT_TIMESTAMP(); 
                   ''', (end_date,)
                   )
    
    theData = cursor.fetchall()
    
    the_response = make_response(jsonify(theData))
    the_response.status_code = 200
    return the_response

# Approve a specific listing
@listings.route('/listings/approve/<listingID>', methods=['PUT'])
def approve_listing(listing_id):
    query = '''
        UPDATE listings SET verification_status = TRUE WHERE listing_id = %s
    '''
    data = (listing_id)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    the_response = make_response(jsonify('listing approved!'))
    the_response.status_code = 200
    return the_response

# Deny a specific listing
@listings.route('/listings/deny/<listingID>', methods=['PUT'])
def deny_listing(listing_id):
    query = '''
        UPDATE listings SET verification_status = FALSE WHERE listing_id = %s
    '''
    data = (listing_id)

    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    the_response = make_response(jsonify('listing denied!'))
    the_response.status_code = 200
    return the_response

# Get a listing based on optional filters
@listings.route('/listings/filter', methods=['GET'])
def filter_listings():
    current_app.logger.info('GET /listings/filter route')
    
    # Get filters from the query string (using request.args.get for optional parameters)
    rent_amount = request.args.get('rent_amount', type=int)
    title = request.args.get('title', type=str)
    description = request.args.get('description', type=str)
    amenities = request.args.get('amenities', type=str)
    safety_rating = request.args.get('safety_rating', type=int)
    location = request.args.get('location', type=str)
    created_by = request.args.get('created_by', type=int)
    neighborhood_id = request.args.get('neighborhood_id', type=int)
    house_number = request.args.get('house_number', type=int)
    street = request.args.get('street', type=str)
    city = request.args.get('city', type=str)
    zipcode = request.args.get('zipcode', type=str)
    verification_status = request.args.get('verification_status', type=bool)
    timeline = request.args.get('timeline', type=str)

    # Start building the query
    query = 'SELECT * FROM listings WHERE 1=1'  # Base query with `WHERE 1=1` for easy appending of conditions
    filters = []

    # Add filters to the query dynamically based on provided parameters
    if rent_amount:
        query += ' AND rent_amount = %s'
        filters.append(rent_amount)
    
    if title:
        query += ' AND title LIKE %s'
        filters.append(f"%{title}%")
    
    if description:
        query += ' AND description LIKE %s'
        filters.append(f"%{description}%")
    
    if amenities:
        query += ' AND amenities LIKE %s'
        filters.append(f"%{amenities}%")
    
    if safety_rating:
        query += ' AND safety_rating = %s'
        filters.append(safety_rating)
    
    if location:
        query += ' AND location LIKE %s'
        filters.append(f"%{location}%")
    
    if created_by:
        query += ' AND created_by = %s'
        filters.append(created_by)
    
    if neighborhood_id:
        query += ' AND neighborhood_id = %s'
        filters.append(neighborhood_id)
    
    if house_number:
        query += ' AND house_number = %s'
        filters.append(house_number)
    
    if street:
        query += ' AND street LIKE %s'
        filters.append(f"%{street}%")
    
    if city:
        query += ' AND city LIKE %s'
        filters.append(f"%{city}%")
    
    if zipcode:
        query += ' AND zipcode = %s'
        filters.append(zipcode)
    
    if verification_status is not None:  # Check for bool values (True/False)
        query += ' AND verification_status = %s'
        filters.append(verification_status)
    
    if timeline:
        query += ' AND timeline LIKE %s'
        filters.append(f"%{timeline}%")

    # Execute the query
    cursor = db.get_db().cursor()
    cursor.execute(query, tuple(filters))
    data = cursor.fetchall()

    # If no results, return a message
    if not data:
        response = make_response(jsonify({'message': 'No listings found matching the filters.'}))
        response.status_code = 404
        return response

    # Return the filtered listings
    response = make_response(jsonify(data))
    response.status_code = 200
    return response