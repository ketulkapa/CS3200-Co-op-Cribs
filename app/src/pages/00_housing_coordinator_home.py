import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Housing Coordinator, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('View Dashboards', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/01_View_Dashboards.py')

if st.button('View All Users', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/02_View_Users.py')

if st.button('Update a Listing',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/03_Update_Listing.py')

if st.button('Delete a Listing',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/04_Delete_Listing.py')

if st.button('View All Recently Posted Listings',
             type='primary',
             use_container_width=True):
  st.switch_page('pages/05_Recent_Listings.py')