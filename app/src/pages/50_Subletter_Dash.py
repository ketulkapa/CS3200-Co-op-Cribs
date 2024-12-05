import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

# Set page configuration
st.set_page_config(layout='wide')

# Show sidebar navigation links
SideBarLinks()

# Title and introduction
st.title(f"Welcome, {st.session_state['first_name']}!")
st.write('')
st.write('')
st.write("### Streamline your subletting process with these options:")

# Main action buttons
if st.button('Manage Your Listing', type='primary', use_container_width=True):
    st.switch_page('pages/51_Manage_Listing.py')

if st.button('Find and Connect with Subletters', type='primary', use_container_width=True):
    st.switch_page('pages/52_Find_Subletter.py')

if st.button('View Subletter Reviews & Matches', type='primary', use_container_width=True):
    st.switch_page('pages/53_Reviews_and_Matches.py')
