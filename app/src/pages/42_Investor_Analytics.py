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

# Get all analytics dashboards
try:
    api_url_all = 'http://api:4000/d/dashboard'
    response_all = requests.get(api_url_all)
        
    if response_all.status_code == 200:
        analytics_data = response_all.json()
        if analytics_data:
            st.write("### Analytics Dashboards")
            st.dataframe(analytics_data)
        else:
            st.write("No analytics dashboards found.")
    else:
        st.error(f"Failed to fetch analytics dashboards. Status code: {response_all.status_code}")
        logger.error(f"Error fetching analytics dashboards: {response_all.text}")
except Exception as e:
    st.error("An error occurred while fetching the analytics dashboards.")
    logger.exception("Exception while fetching analytics dashboards")

# Input field for dashboard ID to fetch specific dashboard
dashboard_id = st.text_input("Enter Dashboard ID to view specific details", "")

if dashboard_id.strip():
    try:
        api_url_by_id = f'http://api:4000/d/dashboard/{dashboard_id}'
        response_by_id = requests.get(api_url_by_id)
        
        if response_by_id.status_code == 200:
            dashboard_data = response_by_id.json()
            if dashboard_data:
                st.write(f"### Dashboard Details for ID {dashboard_id}")
                st.dataframe(dashboard_data)
            else:
                st.write(f"No dashboard found with ID {dashboard_id}.")
        else:
            st.error(f"Failed to fetch dashboard. Status code: {response_by_id.status_code}")
            logger.error(f"Error fetching dashboard by ID: {response_by_id.text}")
    except Exception as e:
        st.error(f"An error occurred while fetching the dashboard with ID {dashboard_id}.")
        logger.exception(f"Exception while fetching dashboard by ID {dashboard_id}")
