import logging
logger = logging.getLogger(__name__)
import streamlit as st
from streamlit_extras.app_logo import add_logo
import pandas as pd
import pydeck as pdk
from urllib.error import URLError
from modules.nav import SideBarLinks
import requests

SideBarLinks()

# add the logo
add_logo("assets/logo.png", height=400)

# set up the page
st.markdown("# All User Information")
st.write('Here is all the information about all the users in the system.')


# Get all users from the API
def get_users(api_url):
    try:
        response = requests.get(api_url)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        logger.error(f"Error fetching users: {e}")
        return []
    
api_url = "http://web-api:4000/u/users"
users = get_users(api_url)
if users:
    df = pd.DataFrame(users)
    st.dataframe(df)
else:
    st.write("No users available.")