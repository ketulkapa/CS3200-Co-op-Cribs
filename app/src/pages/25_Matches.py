import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Initialize logger
logger = logging.getLogger(__name__)

# Add sidebar links
SideBarLinks()

# Set up the page layout
st.title("Matches")
st.write("## View Current Matches")

# Backend API URL base
API_BASE_URL = "http://api:4000/x/matches"

# User inputs to simulate logged-in user and receiver
user_id = st.text_input("Your User ID", value="")

# Display matches for the current user
st.write("### Your Current Matches")
if user_id.strip():
    try:
        response = requests.get(f"{API_BASE_URL}/{user_id}")
        
        if response.status_code == 200:
            matches = response.json()
            if matches:
                st.dataframe(matches)
            else:
                st.write("No matches found.")
        elif response.status_code == 404:
            st.write("No matches found for your user ID.")
        else:
            st.error(f"Failed to fetch matches. Status code: {response.status_code}")
            logger.error(f"Error fetching matches: {response.text}")
    except Exception as e:
        st.error("An error occurred while fetching matches.")
        logger.exception("Exception while fetching matches")
else:
    st.info("Enter your User ID to view matches.")
