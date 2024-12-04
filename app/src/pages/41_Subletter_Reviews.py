import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Initialize logger
logger = logging.getLogger(__name__)

# Add sidebar links
SideBarLinks()

# Set up the page layout
st.write("# Subletter Reviews")

"""
Find all the reviews for a specific subletter.
"""

# Input field for reviewee ID
reviewee_id = st.text_input("Enter the Reviewee ID:", value="")

# Button to trigger API request
if st.button("Get Reviews"):
    if reviewee_id.strip():
        try:
            api_url = f'http://localhost:4000/reviews/{reviewee_id}'
            response = requests.get(api_url)
            
            if response.status_code == 200:
                reviews_data = response.json()
                if reviews_data:
                    st.write("### Reviews for Subletter ID:", reviewee_id)
                    st.dataframe(reviews_data)
                else:
                    st.write("No reviews found for this subletter.")
            else:
                st.error(f"Failed to fetch reviews. Status code: {response.status_code}")
                logger.error(f"Error fetching reviews: {response.text}")
        except Exception as e:
            st.error("An error occurred while fetching the reviews.")
            logger.exception("Exception while fetching reviews")
    else:
        st.warning("Please enter a valid Reviewee ID.")
