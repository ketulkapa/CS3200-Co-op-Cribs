import logging
import streamlit as st
from streamlit_extras.app_logo import add_logo
from streamlit.runtime.scriptrunner import RerunException, RerunData
import numpy as np
import random
import time
from modules.nav import SideBarLinks
import requests
import pandas as pd

logger = logging.getLogger(__name__)

SideBarLinks()

# Define today's date in US/Eastern timezone
today = pd.to_datetime('today', utc=True).tz_convert('US/Eastern').tz_localize(None)

# Function to fetch listings from the API
def get_results(date):
    formatted_date = date.strftime('%Y-%m-%d')
    logger.info(f"Fetching listings from {formatted_date}")
    url = f"http://web-api:4000/l/listings/new/{formatted_date}"
    response = requests.get(url)
    if response.status_code == 200:
        return response.json()
    else:
        st.warning("No listings found :(")

st.title("See Recent Listings")
st.write("##### Choose how recent you want the listings to be.")
date = st.date_input("From", value=today - pd.DateOffset(days=30), format="MM/DD/YYYY", max_value=today)
st.date_input("To", value=today, format="MM/DD/YYYY", disabled=True)

# Button to fetch the listings
if st.button("Get Recent Listings", type='secondary'):
    results = get_results(date)
    if results:
        st.dataframe(results)