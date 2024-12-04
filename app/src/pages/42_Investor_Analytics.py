import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Initialize logger
logger = logging.getLogger(__name__)

# Add sidebar links
SideBarLinks()

# Set up the page layout
st.write("# Analytics Dashboards")

"""
Find analytics regarding seasonal trends and vacancy rates.
"""

# Button to trigger API request
try:
    # Replace with the actual API URL for your environment
    api_url = 'http://api:4000/d/dashboard'
    response = requests.get(api_url)
        
    if response.status_code == 200:
        analytics_data = response.json()
        if analytics_data:
            st.write("### Analytics Dashboards")
            st.dataframe(analytics_data)
        else:
            st.write("No analytics dashboards found.")
    else:
        st.error(f"Failed to fetch analytics dashboards. Status code: {response.status_code}")
        logger.error(f"Error fetching analytics dashboards: {response.text}")
except Exception as e:
    st.error("An error occurred while fetching the analytics dashboards.")
    logger.exception("Exception while fetching analytics dashboards")
