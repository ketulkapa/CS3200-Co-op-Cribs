import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Initialize logger
logger = logging.getLogger(__name__)

# Add sidebar links
SideBarLinks()

# Set up the page layout
st.title("Filter Listings")
st.write("## Find your perfect listing based on filters")

# Backend API URL base
API_BASE_URL = "http://web-api:4000/l/listings/filter"

# User input filters
st.write("### Apply Filters")

# Filters for the listings
rent_min = st.number_input("Minimum Rent", min_value=0, value=1000, step=100)
rent_max = st.number_input("Maximum Rent", min_value=0, value=3000, step=100)
location = st.text_input("Location (e.g., neighborhood or city)", "")
zipcode = st.text_input("Zipcode", "")
amenities = st.text_input("Amenities (e.g., WiFi, Parking)", "")
safety_rating = st.text_input("Safety Rating (1-10)")

# Form to filter the listings
st.write("### Filtered Listings")
with st.form(key='filter_form'):
    submit_filter = st.form_submit_button("Apply Filters")
    
    if submit_filter:
        try:
            # Prepare the filter parameters to send in the request
            filters = {
                "rent_min": rent_min,
                "rent_max": rent_max,
                "location": location,
                "zipcode": zipcode,
                "amenities": amenities,
                "safety_rating": safety_rating
            }

            # Send the filters to the backend API
            response = requests.get(API_BASE_URL, params=filters)

            if response.status_code == 200:
                listings = response.json()
                if listings:
                    st.dataframe(listings)
                else:
                    st.write("No listings found with the selected filters.")
            else:
                st.error(f"Failed to fetch listings. Status code: {response.status_code}")
                logger.error(f"Error fetching listings: {response.text}")
        except Exception as e:
            st.error("An error occurred while fetching the listings.")
            logger.exception("Exception while fetching listings")