import logging
logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
from streamlit_extras.app_logo import add_logo
import world_bank_data as wb
import matplotlib.pyplot as plt
import numpy as np
import plotly.express as px
from modules.nav import SideBarLinks
import requests

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page
st.header('Dashboards')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")

st.write('##### Here are the dashboards available to you.')

# Get Dashboards from api
def get_dashboards(api_url):
    try:
        response = requests.get(api_url)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        logger.error(f"Error fetching dashboards: {e}")
        return []

api_url = "http://web-api:4000/d/dashboard/coordinator/1"
dashboards = get_dashboards(api_url)
if dashboards:
    df = pd.DataFrame(dashboards)
    st.dataframe(df)
else:
    st.write("No dashboards available.")
