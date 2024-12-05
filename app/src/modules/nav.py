# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has function to add certain functionality to the left side bar of the app

import streamlit as st


#### ------------------------ General ------------------------
def HomeNav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")


def AboutPageNav():
    st.sidebar.page_link("pages/30_About.py", label="About", icon="🧠")


#### ------------------------ Examples for Role of housing coordinator ------------------------
def HousingCoordHomeNav():
    st.sidebar.page_link(
        "pages/00_housing_coordinator_home.py", label="Housing Coordinator Home", icon="🏠"
    )


def HousingDashboardsNav():
    st.sidebar.page_link(
        "pages/01_View_Dashboards.py", label="Dashboards", icon="📈"
    )


def HousingUserNav():
    st.sidebar.page_link(
        "pages/02_View_Users.py", label="Users", icon="👤"
    )

def HousingUpdateListingNav():
    st.sidebar.page_link(
        "pages/03_Update_Listing.py", label="Update Listing", icon="✨"
    )

def HousingDeleteListingNav():
    st.sidebar.page_link(
        "pages/04_Delete_Listing.py", label="Delete Listing", icon="🗑️"
    )

def HousingRecentListingsNav():
    st.sidebar.page_link(
        "pages/05_Recent_Listings.py", label="Recent Listings", icon="🔎"
    )

#### ------------------------ Examples for Role of Investor ------------------------
def InvestorHomeNav():
    st.sidebar.page_link(
        "pages/40_Investor_Home.py", label="Investor Home", icon="🏠"
    )


def InvestorReviewsNav():
    st.sidebar.page_link(
        "pages/41_Subletter_Reviews.py", label="Reviews", icon="✨"
    )


def InvestorAnalyticsNav():
    st.sidebar.page_link(
        "pages/42_Investor_Analytics.py", label="Analytics", icon="📈"
    )

def InvestorMessagingNav():
    st.sidebar.page_link(
        "pages/43_Messaging.py", label="Messaging", icon="👤"
    )

## ------------------------ Examples for Role of usaid_worker ------------------------
def ApiTestNav():
    st.sidebar.page_link("pages/12_API_Test.py", label="Test the API", icon="🛜")


def PredictionNav():
    st.sidebar.page_link(
        "pages/11_Prediction.py", label="Regression Prediction", icon="📈"
    )


def ClassificationNav():
    st.sidebar.page_link(
        "pages/13_Classification.py", label="Classification Demo", icon="🌺"
    )


#### ------------------------ System Admin Role ------------------------
def RameshHomeNav():
    st.sidebar.page_link(
        "pages/20_Ramesh_Home.py", label="Ramesh Home", icon="🏠"
    )

def RameshListingsSearch():
    st.sidebar.page_link(
        "pages/21_Listings.py", label="Listings Sarch", icon="📈"
    )

def RameshMessages():
    st.sidebar.page_link(
        "pages/22_Messaging.py", label="Messages", icon="💬"
    )

def RameshEventsSearch():
    st.sidebar.page_link(
        "pages/23_Events.py", label="Events", icon="🎉"
    )

def RameshMatches():
    st.sidebar.page_link(
        "pages/23_Events.py", label="Events", icon="🌺"
    )

def RameshNeighborhoodsSearch():
    st.sidebar.page_link(
        "pages/26_Neighborhoods.py", label="Neighborhoods", icon="🔎"
    )


# --------------------------------Links Function -----------------------------------------------
def SideBarLinks(show_home=False):
    """
    This function handles adding links to the sidebar of the app based upon the logged-in user's role, which was put in the streamlit session_state object when logging in.
    """

    # add a logo to the sidebar always
    st.sidebar.image("assets/logo.png", width=150)

    # If there is no logged in user, redirect to the Home (Landing) page
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page("Home.py")

    if show_home:
        # Show the Home page link (the landing page)
        HomeNav()

    # Show the other page navigators depending on the users' role.
    if st.session_state["authenticated"]:

        # Show World Bank Link and Map Demo Link if the user is a political strategy advisor role.
        if st.session_state["role"] == "housing_coordinator":
            HousingCoordHomeNav()
            HousingDashboardsNav()
            HousingUserNav()
            HousingUpdateListingNav()
            HousingDeleteListingNav()
            HousingRecentListingsNav()

        # If the user role is usaid worker, show the Api Testing page
        if st.session_state["role"] == "investor":
            InvestorHomeNav()
            InvestorReviewsNav()
            InvestorAnalyticsNav()
            InvestorMessagingNav()

        # If the user is an administrator, give them access to the administrator pages
        if st.session_state["role"] == "administrator":
            AdminPageNav()

    # Always show the About page at the bottom of the list of links
    AboutPageNav()

    if st.session_state["authenticated"]:
        # Always show a logout button if there is a logged in user
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")
