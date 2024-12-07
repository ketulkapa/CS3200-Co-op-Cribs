import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Initialize logger
logger = logging.getLogger(__name__)

# Add sidebar links
SideBarLinks()

# Set up the page layout
st.write("# Create or Update a Listing")

"""
Manage your property listings efficiently.
"""

# Input fields for creating or updating a listing
listing_id = st.text_input("Listing ID (for updates only):", value="")
rent_amount = st.number_input("Rent Amount (in USD):", min_value=0, value=0)
title = st.text_input("Listing Title:", value="")
description = st.text_area("Description:", value="")
amenities = st.text_input("Amenities (comma-separated):", value="")
safety_rating = st.slider("Safety Rating (1-5):", min_value=1, max_value=5, value=3)
location = st.text_input("Location (general area):", value="")
created_by = st.text_input("Created By (user ID):", value="")
neighborhood_id = st.text_input("Neighborhood ID:", value="")
house_number = st.text_input("House Number:", value="")
street = st.text_input("Street:", value="")
city = st.text_input("City:", value="")
zipcode = st.text_input("Zip Code:", value="")
verification_status = st.selectbox("Verification Status:", ["Pending", "Approved", "Denied"])
timeline = st.text_input("Timeline (e.g., 6 months):", value="")

# Button to create a new listing
if st.button("Create Listing"):
    # Validate required fields
    if rent_amount > 0 and title.strip() and location.strip() and created_by.strip():
        try:
            api_url = 'http://web-api:4000/l/listings'
            listing_data = {
                "rent_amount": rent_amount,
                "title": title,
                "description": description,
                "amenities": amenities,
                "safety_rating": safety_rating,
                "location": location,
                "created_by": created_by,
                "neighborhood_id": neighborhood_id,
                "house_number": house_number,
                "street": street,
                "city": city,
                "zipcode": zipcode,
                "verification_status": verification_status,
                "timeline": timeline,
            }
            response = requests.post(api_url, json=listing_data)

            if response.status_code == 201:  # 201 Created
                st.success("Listing created successfully!")
                logger.info("Listing created successfully.")
            else:
                st.error(f"Failed to create listing. Status code: {response.status_code}")
                logger.error(f"Error creating listing: {response.text}")
        except Exception as e:
            st.error("An error occurred while creating the listing.")
            logger.exception("Exception while creating listing")
    else:
        st.warning("Please fill in all required fields.")

# Button to update an existing listing
if st.button("Update Listing"):
    # Validate required fields for update
    if listing_id.strip() and rent_amount > 0 and title.strip() and location.strip():
        try:
            api_url = f'http://web-api:4000/l/listings/{listing_id}'
            listing_data = {
                "rent_amount": rent_amount,
                "title": title,
                "description": description,
                "amenities": amenities,
                "safety_rating": safety_rating,
                "location": location,
                "neighborhood_id": neighborhood_id,
                "house_number": house_number,
                "street": street,
                "city": city,
                "zipcode": zipcode,
                "verification_status": verification_status,
                "timeline": timeline,
            }
            response = requests.put(api_url, json=listing_data)

            if response.status_code == 200:  # 200 OK
                st.success("Listing updated successfully!")
                logger.info("Listing updated successfully.")
            else:
                st.error(f"Failed to update listing. Status code: {response.status_code}")
                logger.error(f"Error updating listing: {response.text}")
        except Exception as e:
            st.error("An error occurred while updating the listing.")
            logger.exception("Exception while updating listing")
    else:
        st.warning("Please fill in all required fields for update.")

# Optional button to view all listings
if st.button("View All Listings"):
    try:
        api_url = 'http://web-api:4000/l/listings'
        response = requests.get(api_url)

        if response.status_code == 200:
            all_listings = response.json()
            if all_listings:
                st.write("### All Listings")
                st.dataframe(all_listings)
            else:
                st.write("No listings are currently available.")
        else:
            st.error(f"Failed to fetch listings. Status code: {response.status_code}")
            logger.error(f"Error fetching listings: {response.text}")
    except Exception as e:
        st.error("An error occurred while fetching the listings.")
        logger.exception("Exception while fetching listings")
