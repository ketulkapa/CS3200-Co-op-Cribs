import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Investor, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('View Reviews For Subletter', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/41_Subletter_Reviews.py')

if st.button('Message User', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/43_Messaging.py')

if st.button('View Analytics', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/42_Investor_Analytics.py')

if st.button('Approve or Deny Subletter', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/44_Review_Subletter.py')