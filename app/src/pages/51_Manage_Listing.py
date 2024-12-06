import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Initialize logger
logger = logging.getLogger(__name__)

# Add sidebar links
SideBarLinks()

# Set up the page layout
st.write("# Create a New Listing")

"""
Add a new listing to connect with subletters.
"""

# Input fields for creating a new listing
title = st.text_input("Listing Title:", value="")
location = st.text_input("Location:", value="")
rent_amount = st.number_input("Rent Amount (in USD):", min_value=0, value=0)
start_date = st.date_input("Available From:")
end_date = st.date_input("Available Until:")
description = st.text_area("Listing Description:", value="")

# Button to submit the new listing
if st.button("Create Listing"):
    # Ensure all required fields are filled
    if title.strip() and location.strip() and rent_amount > 0 and start_date and end_date:
        try:
            # Prepare the data to send in the POST request
            listing_data = {
                "title": title,
                "location": location,
                "rent_amount": rent_amount,
                "start_date": str(start_date),
                "end_date": str(end_date),
                "description": description,
            }
            api_url = 'http://api:4000/listings/create'
            logger.info(f"Sending POST request to {api_url} with data: {listing_data}")
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

# Button to show all existing listings
if st.button("View All Listings"):
    try:
        api_url = 'http://api:4000/listings'
        logger.info(f"Fetching all listings from {api_url}")
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