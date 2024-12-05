import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Initialize logger
logger = logging.getLogger(__name__)

# Add sidebar links
SideBarLinks()

# Set up the page layout
st.write("# Events Near Me")

"""
Find all the events in a zipcode.
"""

# Input field for zipcode of event
zipcode = st.text_input("Enter the zipcode you want to find an event in:", value="")

# Button to trigger API request
if st.button("Get Events"):
    if zipcode.strip():
        try:
            api_url = f'http://api:4000/e/events/{zipcode}'
            response = requests.get(api_url)
            
            if response.status_code == 200:
                events_data = response.json()
                if events_data:
                    st.write("### Events for Zipcode:", zipcode)
                    st.dataframe(events_data)
                else:
                    st.write("No events found in this zipcode.")
            else:
                st.error(f"Failed to fetch events. Status code: {response.status_code}")
                logger.error(f"Error fetching events: {response.text}")
        except Exception as e:
            st.error("An error occurred while fetching the events.")
            logger.exception("Exception while fetching events")
    else:
        st.warning("Please enter a valid zipcode.")