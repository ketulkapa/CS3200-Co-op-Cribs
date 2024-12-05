import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Initialize logger
logger = logging.getLogger(__name__)

# Add sidebar links
SideBarLinks()

# Set up the page layout
st.write("# Listing Matching")

"""
Find available listings based on filters.
"""

# Input fields for filtering listings
rent_amount = st.number_input("Rent Amount:", min_value=0, value=0)
title = st.text_input("Title:", value="")
location = st.text_input("Location:", value="")

# Button to trigger API request for filtered listings
if st.button("Apply Filters"):
    filter_params = {}
    if rent_amount:
        filter_params['rent_amount'] = rent_amount
    if title:
        filter_params['title'] = title
    if location:
        filter_params['location'] = location

    if filter_params:
        try:
            api_url = 'http://api:4000/listings/filter'
            response = requests.get(api_url, params=filter_params)

            if response.status_code == 200:
                listings_data = response.json()
                if listings_data:
                    st.write("### Matching Listings")
                    st.dataframe(listings_data)
                else:
                    st.write("No listings found with the provided filters.")
            else:
                st.error(f"Failed to fetch listings. Status code: {response.status_code}")
                logger.error(f"Error fetching listings: {response.text}")
        except Exception as e:
            st.error("An error occurred while fetching the listings.")
            logger.exception("Exception while fetching listings")
    else:
        st.warning("Please provide at least one filter value.")

# Button to show new listings (created in the last 7 days)
if st.button("Show New Listings"):
    try:
        api_url = 'http://api:4000/listings/new'
        response = requests.get(api_url)

        if response.status_code == 200:
            new_listings_data = response.json()
            if new_listings_data:
                st.write("### Listings Created in the Last 7 Days")
                st.dataframe(new_listings_data)
            else:
                st.write("No new listings in the past 7 days.")
        else:
            st.error(f"Failed to fetch new listings. Status code: {response.status_code}")
            logger.error(f"Error fetching new listings: {response.text}")
    except Exception as e:
        st.error("An error occurred while fetching new listings.")
        logger.exception("Exception while fetching new listings")