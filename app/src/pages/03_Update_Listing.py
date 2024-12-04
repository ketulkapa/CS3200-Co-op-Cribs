import logging
logger = logging.getLogger(__name__)
import streamlit as st
from streamlit_extras.app_logo import add_logo
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
if st.button("Fetch Listing"):
  # Get listing details from the api
  def fetch_listing_details(listing_id):
    url = f"http://web-api:4000/l/listings/{listing_id}"
    response = requests.get(url)
    if response.status_code == 200:
      return response.json()[0]
    else:
      st.error("Failed to fetch listing details.")
  st.session_state['listing_details'] = fetch_listing_details(listing_id)
  listing_details = st.session_state['listing_details']

  listing_details = fetch_listing_details(listing_id)

if listing_details:
  new_price = st.text_input("Enter New Price:", value=listing_details.get('rent_amount', ''))
  new_title = st.text_input("Enter New Title:", value=listing_details.get('title', ''))
  new_description = st.text_area("Enter New Description:", value=listing_details.get('description', ''))
  new_amenities = st.text_area("Enter New Amenities:", value=listing_details.get('amenities', ''))
  new_match_score = st.number_input("Enter New Match Score:", min_value=0, max_value=100, value=listing_details.get('match_score', 0))
  new_safety_rating = st.number_input("Enter New Safety Rating:", min_value=0, max_value=100, value=listing_details.get('safety_rating', 0))
  new_location = st.text_input("Enter New Location:", value=listing_details.get('location', ''))
  new_neighborhood_id = st.number_input("Enter New Neighborhood ID:", min_value=0, value=listing_details.get('neighborhood_id', 0))
  new_house_number = st.number_input("Enter New House Number:", min_value=0, value=listing_details.get('house_number', 0))
  new_street = st.text_input("Enter New Street:", value=listing_details.get('street', ''))
  new_city = st.text_input("Enter New City:", value=listing_details.get('city', ''))
  new_zipcode = st.number_input("Enter New Zipcode:", min_value=0, value=listing_details.get('zipcode', 0))
  new_verification_status = st.checkbox("New Verification Status", value=listing_details.get('verification_status', False))
  new_timeline = st.number_input("Enter New Timeline:", min_value=0, value=listing_details.get('timeline', 0))

# # Button to submit the updated listing details
# if st.button("Update Listing"):
#   # Code to update the listing in the database goes here
#   st.success("Listing updated successfully!")

