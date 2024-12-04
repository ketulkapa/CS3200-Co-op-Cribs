import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Initialize logger
logger = logging.getLogger(__name__)

# Add sidebar links
SideBarLinks()

# Set up the page layout
st.title("Messages")
st.write("## Send and View Messages")

# Backend API URL base
API_BASE_URL = "http://api:4000/m/messages"

# User inputs to simulate logged-in user and receiver
current_user_id = st.text_input("Your User ID", value="")
receiver_id = st.text_input("Receiver User ID", value="")

# Form for sending a message
st.write("### Send a Message")
with st.form(key='send_message_form'):
    message_content = st.text_area("Message Content")
    submit_message = st.form_submit_button("Send Message")
    
    if submit_message:
        if current_user_id and receiver_id and message_content.strip():
            try:
                payload = {
                    "sender_id": current_user_id,
                    "receiver_id": receiver_id,
                    "content": message_content
                }
                response = requests.post(API_BASE_URL, json=payload)
                
                if response.status_code == 201:
                    st.success("Message sent successfully!")
                else:
                    st.error(f"Failed to send message. Status code: {response.status_code}")
                    logger.error(f"Error sending message: {response.text}")
            except Exception as e:
                st.error("An error occurred while sending the message.")
                logger.exception("Exception while sending message")
        else:
            st.warning("Please fill in all fields to send a message.")

# Display received messages for the current user
st.write("### Your Received Messages")
if current_user_id.strip():
    try:
        response = requests.get(f"{API_BASE_URL}/{current_user_id}")
        
        if response.status_code == 200:
            messages = response.json().get('messages', [])
            if messages:
                st.dataframe(messages)
            else:
                st.write("No messages found.")
        elif response.status_code == 404:
            st.write("No messages found for your user ID.")
        else:
            st.error(f"Failed to fetch messages. Status code: {response.status_code}")
            logger.error(f"Error fetching messages: {response.text}")
    except Exception as e:
        st.error("An error occurred while fetching messages.")
        logger.exception("Exception while fetching messages")
else:
    st.info("Enter your User ID to view received messages.")
