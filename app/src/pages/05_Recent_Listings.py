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

def get_results(date):
    url = f"http://web-api:4000/l/listings?date={date}"
    response = requests.get(url)
    if response.status_code == 200:
        return response.json()
    else:
        st.warning("No listings found :(")

st.title("See Recent Listings")
st.write("##### Choose how recent you want the listings to be.")
date = st.date_input("From", value=pd.to_datetime("today") - pd.DateOffset(days=30), format="MM/DD/YYYY")
st.date_input("To", value=pd.to_datetime("today"), format="MM/DD/YYYY", disabled=True)
st.button("Get Recent Listings", type='secondary', on_click=get_results(date))