import logging
logger = logging.getLogger(__name__)
import streamlit as st
from streamlit_extras.app_logo import add_logo
from streamlit.runtime.scriptrunner import RerunException, RerunData
import numpy as np
import random
import time
from modules.nav import SideBarLinks
import requests

SideBarLinks()

st.title("Update Listing")
st.write("##### Update the details of a listing.")

# Input fields for listing ID
listing_id = st.text_input("Enter the Listing ID:", value="", help="Enter the ID of the listing you want to update.")

# Initialize listing_details in session state
if 'listing_details' not in st.session_state:
    st.session_state['listing_details'] = None
listing_details = st.session_state['listing_details']

# Button to fetch the listing details
if st.button("Fetch Listing",
             type='secondary'):
  # Get listing details from the api
  def fetch_listing_details(listing_id):
    url = f"http://web-api:4000/l/listings/{listing_id}"
    response = requests.get(url)
    if response.status_code == 200:
      return response.json()[0]
    else:
      st.warning("Listing does not exist :(")
  st.session_state['listing_details'] = fetch_listing_details(listing_id)
  listing_details = st.session_state['listing_details']

if listing_details:
  new_price = st.number_input("Enter New Price:", min_value=0, value=int(listing_details.get('rent_amount', 0)))
  new_title = st.text_input("Enter New Title:", value=listing_details.get('title', ''))
  new_description = st.text_area("Enter New Description:", value=listing_details.get('description', ''))
  new_amenities = st.text_area("Enter New Amenities:", value=listing_details.get('amenities', ''))
  new_match_score = st.number_input("Enter New Match Score:", min_value=0, max_value=100, value=int(listing_details.get('match_score', 0)))
  new_safety_rating = st.number_input("Enter New Safety Rating:", min_value=0, max_value=100, value=int(listing_details.get('safety_rating', 0)))
  new_location = st.text_input("Enter New Location:", value=listing_details.get('location', ''))
  new_neighborhood_id = st.number_input("Enter New Neighborhood ID:", min_value=0, value=int(listing_details.get('neighborhood_id', 0)))
  new_house_number = st.number_input("Enter New House Number:", min_value=0, value=int(listing_details.get('house_number', 0)))
  new_street = st.text_input("Enter New Street:", value=listing_details.get('street', ''))
  new_city = st.text_input("Enter New City:", value=listing_details.get('city', ''))
  new_zipcode = st.number_input("Enter New Zipcode:", min_value=0, value=int(listing_details.get('zipcode', 0)))
  new_verification_status = st.checkbox("New Verification Status", value=bool(listing_details.get('verification_status', False)))
  new_timeline = st.number_input("Enter New Timeline:", min_value=0, value=int(listing_details.get('timeline', 0)))

# Button to submit the updated listing details
if listing_details:
  if st.button("Update Listing",
              type='secondary'):
    url = f"http://web-api:4000/l/listings/{listing_id}"
    payload = {
      "rent_amount": new_price,
      "title": new_title,
      "description": new_description,
      "amenities": new_amenities,
      "match_score": new_match_score,
      "safety_rating": new_safety_rating,
      "location": new_location,
      "neighborhood_id": new_neighborhood_id,
      "house_number": new_house_number,
      "street": new_street,
      "city": new_city,
      "zipcode": new_zipcode,
      "verification_status": new_verification_status,
      "timeline": new_timeline
    }
    response = requests.put(url, json=payload)
    if response.status_code == 200:
      st.success("Listing updated successfully!")
    else:
      st.error("Failed to update listing.")

