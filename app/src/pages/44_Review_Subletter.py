import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Initialize logger
logger = logging.getLogger(__name__)

# Add sidebar links
SideBarLinks()

# Set up the page layout
st.title("Approve or Deny Subletter Listings")
st.write("### Manage Subletter Listings")

# Backend API URL base
API_BASE_URL = "http://api:4000/l/listings"

# Input field for listing ID
listing_id = st.text_input("Enter Listing ID", value="")

# Option to approve or deny the listing
if listing_id.strip():
    st.write("### Choose an Action")
    approve_button = st.button("Approve Listing")
    deny_button = st.button("Deny Listing")

    # Approve listing
    if approve_button:
        try:
            response = requests.put(f"{API_BASE_URL}/approve/{listing_id}")
            if response.status_code == 200:
                st.success("Listing approved successfully!")
            else:
                st.error(f"Failed to approve listing. Status code: {response.status_code}")
                logger.error(f"Error approving listing: {response.text}")
        except Exception as e:
            st.error("An error occurred while approving the listing.")
            logger.exception("Exception while approving listing")

    # Deny listing
    if deny_button:
        try:
            response = requests.put(f"{API_BASE_URL}/deny/{listing_id}")
            if response.status_code == 200:
                st.success("Listing denied successfully!")
            else:
                st.error(f"Failed to deny listing. Status code: {response.status_code}")
                logger.error(f"Error denying listing: {response.text}")
        except Exception as e:
            st.error("An error occurred while denying the listing.")
            logger.exception("Exception while denying listing")
else:
    st.warning("Please enter a valid Listing ID.")
