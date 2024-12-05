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
if "action" not in st.session_state:
    st.session_state.action = "Search for Subletters"

st.session_state.action = st.selectbox(
    "What would you like to do?",
    options=["Search for Subletters", "View Matches", "Send a Message"],
    index=["Search for Subletters", "View Matches", "Send a Message"].index(st.session_state.action)
)

# API endpoints
base_url = "http://api:4000"

# Execute selected action
if st.session_state.action == "Search for Subletters":
    st.write("### Search for Subletters")
    # Persist form field states
    if "budget" not in st.session_state:
        st.session_state.budget = 0
    if "start_date" not in st.session_state:
        st.session_state.start_date = None
    if "end_date" not in st.session_state:
        st.session_state.end_date = None
    if "vibe" not in st.session_state:
        st.session_state.vibe = ""

    # Form fields for search criteria
    st.session_state.budget = st.number_input("Maximum Monthly Rent", min_value=0, value=st.session_state.budget)
    st.session_state.start_date = st.date_input("Start Date", value=st.session_state.start_date)
    st.session_state.end_date = st.date_input("End Date", value=st.session_state.end_date)
    st.session_state.vibe = st.text_input("Preferred Vibe (e.g., quiet, social, etc.)", value=st.session_state.vibe)

    # Trigger search
    if st.button("Search"):
        params = {
            "budget": st.session_state.budget,
            "start_date": str(st.session_state.start_date),
            "end_date": str(st.session_state.end_date),
            "vibe": st.session_state.vibe
        }
        try:
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
        except Exception as e:
            st.error("An error occurred while searching.")
            logger.exception("Error searching subletters")

elif st.session_state.action == "View Matches":
    st.write("### View Your Matches")
    user_id = st.text_input("Enter Your User ID")
    if user_id.strip() and st.button("Get Matches"):
        try:
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
        except Exception as e:
            st.error("An error occurred while retrieving matches.")
            logger.exception("Error retrieving matches")

elif st.session_state.action == "Send a Message":
    st.write("### Send a Message to a Subletter")
    user_id = st.text_input("Enter Your User ID")
    recipient_id = st.text_input("Enter the Recipient's User ID")
    message_content = st.text_area("Enter Your Message")
    if st.button("Send Message"):
        try:
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
            st.error("An error occurred while sending the message.")
            logger.exception("Error sending message")