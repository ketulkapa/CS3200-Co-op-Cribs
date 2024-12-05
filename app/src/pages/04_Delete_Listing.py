import logging
import streamlit as st
from streamlit_extras.app_logo import add_logo
from streamlit.runtime.scriptrunner import RerunException, RerunData
import numpy as np
import random
import time
from modules.nav import SideBarLinks
import requests

logger = logging.getLogger(__name__)

SideBarLinks()

st.title("Delete Listing")
st.write("##### Delete a listing.")

# Input fields for listing ID
listing_id = st.text_input("Enter the Listing ID:", value="", help="Enter the ID of the listing you want to delete.")

# Initialize listing_details in session state
if 'listing_details' not in st.session_state:
  st.session_state['listing_details'] = None
listing_details = st.session_state['listing_details']

# Button to fetch the listing details
if st.button("Fetch Listing", type='secondary'):
  # Get listing details from the api
  def fetch_listing_details(listing_id):
    url = f"http://web-api:4000/l/listings/{listing_id}"
    response = requests.get(url)
    if response.status_code == 200:
      return response.json()[0]
    else:
      st.warning("Listing does not exist :(")
      return None

  st.session_state['listing_details'] = fetch_listing_details(listing_id)
  listing_details = st.session_state['listing_details']

# Button to delete the listing
if listing_details:
  st.write("### Listing Details")
  st.write(f"**Title:** {listing_details.get('title', '')}")
  st.write(f"**Description:** {listing_details.get('description', '')}")
  st.write(f"**Amenities:** {listing_details.get('amenities', '')}")
  st.write(f"**Rent Amount:** {listing_details.get('rent_amount', 0)}")
  st.write(f"**Match Score:** {listing_details.get('match_score', 0)}")
  st.write(f"**Safety Rating:** {listing_details.get('safety_rating', 0)}")
  st.write(f"**Location:** {listing_details.get('location', '')}")
  st.write(f"**Neighborhood ID:** {listing_details.get('neighborhood_id', 0)}")
  st.write(f"**House Number:** {listing_details.get('house_number', 0)}")
  st.write(f"**Street:** {listing_details.get('street', '')}")
  st.write(f"**City:** {listing_details.get('city', '')}")
  st.write(f"**Zipcode:** {listing_details.get('zipcode', 0)}")
  st.write(f"**Verification Status:** {listing_details.get('verification_status', False)}")
  st.write(f"**Timeline:** {listing_details.get('timeline', 0)}")
  st.warning("Note: Deleting a listing is irreversible.")
  if st.button("Delete Listing", type='secondary'):
    url = f"http://web-api:4000/l/listings/{listing_id}"
    response = requests.delete(url)
    if response.status_code == 200:
      st.success("Listing deleted successfully!")
    else:
      st.error("Failed to delete listing.")