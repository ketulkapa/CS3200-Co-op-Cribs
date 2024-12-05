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
                   created_at,
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

@listings.route('/listings/filter', methods=['GET'])
def filter_listings():
    rent_min = request.args.get('rent_min', type=int)
    rent_max = request.args.get('rent_max', type=int)
    location = request.args.get('location', type=str)
    zipcode = request.args.get('zipcode', type=int)
    amenities = request.args.get('amenities', type=str)
    safety_rating = request.args.get('safety_rating', type=int)

    query = 'SELECT * FROM listings WHERE 1=1'
    filters = []

    if rent_min:
        query += ' AND rent_amount >= %s'
        filters.append(rent_min)
    
    if rent_max:
        query += ' AND rent_amount <= %s'
        filters.append(rent_max)
    
    if location:
        query += ' AND location LIKE %s'
        filters.append(f"%{location}%")
    
    if zipcode:
        query += ' AND zipcode = %s'
        filters.append(zipcode)
    
    if amenities:
        query += ' AND amenities LIKE %s'
        filters.append(f"%{amenities}%")
    
    if safety_rating:
        query += ' AND safety_rating = %s'
        filters.append(safety_rating)

    cursor = db.get_db().cursor()
    cursor.execute(query, tuple(filters))
    listings = cursor.fetchall()

    return jsonify(listings)