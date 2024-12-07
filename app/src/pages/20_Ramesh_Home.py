import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Ramesh!")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('Check my messages', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/22_Messaging.py')

if st.button('Check Listings', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/21_Listings.py')

if st.button("Find events near me",
             type='primary',
             use_container_width=True):
  st.switch_page('pages/23_Events.py')

if st.button("Find potential roommates",
             type='primary',
             use_container_width=True):
  st.switch_page('pages/25_Matches.py')

if st.button("Check out neighborhoods",
             type='primary',
             use_container_width=True):
  st.switch_page('pages/26_Neighborhoods.py')