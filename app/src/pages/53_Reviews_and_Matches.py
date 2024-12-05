import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Initialize logger
logger = logging.getLogger(__name__)

# Add sidebar links
SideBarLinks()

# Set up the page layout
st.write("# View Matches")

"""
Find matches for your subletting needs.
"""

# API endpoint
base_url = "http://api:4000"

# Form to input user ID
user_id = st.text_input("Enter Your User ID")

# Button to trigger API request
if st.button("Get Matches"):
    if user_id.strip():
        try:
            api_url = f"{base_url}/matches/{user_id}"
            response = requests.get(api_url)
            
            if response.status_code == 200:
                matches_data = response.json()
                if matches_data:
                    st.write(f"### Matches for User ID: {user_id}")
                    st.dataframe(matches_data)
                else:
                    st.write("No matches found for your user ID.")
            else:
                st.error(f"Failed to retrieve matches. {response.text}")
                logger.error(f"Error retrieving matches: {response.text}")
        except Exception as e:
            st.error("An error occurred while fetching the matches.")
            logger.exception("Exception while fetching matches")
    else:
        st.warning("Please enter a valid User ID.")