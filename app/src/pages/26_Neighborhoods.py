import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Initialize logger
logger = logging.getLogger(__name__)

# Add sidebar links
SideBarLinks()

# Set up the page layout
st.write("# Checking out Neighborhoods")

"""
Find details about a specific neighborhood.
"""

# Input field for zipcode of event
neighborhood = st.text_input("Enter the name of the neighborhood you are looking for:", value="")

# Button to trigger API request
if st.button("Get Neighborhood Details"):
    if neighborhood.strip():
        try:
            api_url = f'http://web-api:4000/n/neighborhoods/{neighborhood}'
            response = requests.get(api_url)
            
            if response.status_code == 200:
                nei_data = response.json()
                if nei_data:
                    st.write("### Neighborhoods with this name and details:", neighborhood)
                    st.dataframe(nei_data)
                else:
                    st.write("No neighborhoods found with this name.")
            else:
                st.error(f"Failed to fetch neighborhoods. Status code: {response.status_code}")
                logger.error(f"Error fetching neighborhoods: {response.text}")
        except Exception as e:
            st.error("An error occurred while fetching the neighborhoods.")
            logger.exception("Exception while fetching neighborhoods")
    else:
        st.warning("Please enter a valid neighborhood name.")