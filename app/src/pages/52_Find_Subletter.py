import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Initialize logger
logger = logging.getLogger(__name__)

# Add sidebar links
SideBarLinks()

# Set up the page layout
st.write("# Find Subletters")

"""
Easily search for subletters that match your preferences, view matches, and send messages.
"""

# Dropdown for selecting an action
action = st.selectbox(
    "What would you like to do?",
    options=["Search for Subletters", "View Matches", "Send a Message"]
)

# API endpoints
base_url = "http://api:4000"

# Action buttons
if st.button("Proceed"):
    try:
        if action == "Search for Subletters":
            st.write("### Search for Subletters")
            # Form fields for search criteria
            budget = st.number_input("Maximum Monthly Rent", min_value=0)
            start_date = st.date_input("Start Date")
            end_date = st.date_input("End Date")
            vibe = st.text_input("Preferred Vibe (e.g., quiet, social, etc.)")
            
            if st.button("Search"):
                params = {
                    "budget": budget,
                    "start_date": str(start_date),
                    "end_date": str(end_date),
                    "vibe": vibe
                }
                response = requests.get(f"{base_url}/listings", params=params)
                if response.status_code == 200:
                    subletters_data = response.json()
                    if subletters_data:
                        st.write("### Subletters Matching Your Criteria")
                        st.dataframe(subletters_data)
                    else:
                        st.write("No subletters found matching your criteria.")
                else:
                    st.error(f"Failed to search for subletters. {response.text}")
                    logger.error(f"Error searching subletters: {response.text}")

        elif action == "View Matches":
            st.write("### View Your Matches")
            user_id = st.text_input("Enter Your User ID")
            
            if user_id.strip() and st.button("Get Matches"):
                response = requests.get(f"{base_url}/matches/{user_id}")
                if response.status_code == 200:
                    matches_data = response.json()
                    if matches_data:
                        st.write("### Your Matches")
                        st.dataframe(matches_data)
                    else:
                        st.write("No matches found for your user ID.")
                else:
                    st.error(f"Failed to retrieve matches. {response.text}")
                    logger.error(f"Error retrieving matches: {response.text}")

        elif action == "Send a Message":
            st.write("### Send a Message to a Subletter")
            user_id = st.text_input("Enter Your User ID")
            recipient_id = st.text_input("Enter the Recipient's User ID")
            message_content = st.text_area("Enter Your Message")
            
            if st.button("Send Message"):
                data = {
                    "sender_id": user_id,
                    "recipient_id": recipient_id,
                    "content": message_content
                }
                response = requests.post(f"{base_url}/messages/{user_id}", json=data)
                if response.status_code == 201:
                    st.success("Message sent successfully!")
                else:
                    st.error(f"Failed to send message. {response.text}")
                    logger.error(f"Error sending message: {response.text}")

    except Exception as e:
        st.error("An error occurred while processing your request.")
        logger.exception("Exception in find subletters actions")