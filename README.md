# Co-Op Cribs

Co-Op Cribs helps Northeastern University students find sublets while on co-op placements. The app connects students leaving their apartments with others in need of temporary housing, making the process of finding a sublet easy and efficient.

Team Members: 
- Ketul Kapadia 
- Arav Goyal
- Cathreen Paul
- Arnav Mishra
- Janvi Lingaiah

## Getting the WebPage Started 

Before interacting with the web app, ensure that Docker containers are running. This is necessary to start the Streamlit app, Flask API, and MySQL database.

To start the containers, run the following in the project directory:
docker compose up

Once this has been perfomed go into docker desktop to make sure the containers web-app, web-api, and mysql_db are running.
Once the containers are running, you can access the web app at http://localhost:8501

## Home Page Features

On the home page, users are greeted with a selection of options to log in as one of the following:

1. Elizabeth, a Housing Coordinator:
A housing coordinator manages student housing listings, connects students with available sublets, and helps with logistics for those on co-op placements.

2. Leah, a Student with an Offer in San Francisco:
A student who has received a co-op offer in San Francisco and is searching for available sublets to stay during the co-op.

3. Ramesh, an International Student with an Offer in New York City:
An international student with a co-op offer in New York City. This user may have specific needs for housing related to being an international student.

4. Sanay, a Real Estate Investor:
A real estate investor looking for opportunities in the student housing market, particularly related to co-op housing and sublets.


## Housing Coordinator Page 
When the Housing Coordinator has been selected you will be navigated to the Housing Coordinator page, which offers a few actionables things:

### Sidebar Navigation:
When you open this page on the side bar as well as on the housing coordinator page there will be navigation links to go through:

Dashboards: Access detailed dashboards for housing data and analytics for the housing.
Users: View all registered users (students).
Update Listing: Manage housing listings by updating available sublets.
Delete Listing: Remove listings that are no longer available.
Recent Listings: View recently posted housing options.
Logout: Sign out of your current session.




## Current Project Components

Currently, there are three major components which will each run in their own Docker Containers:

- Streamlit App in the `./app` directory
- Flask REST api in the `./api` directory
- SQL files for your data model and data base in the `./database-files` directory

## Suggestion for Learning the Project Code Base

If you are not familiar with web app development, this code base might be confusing. You will probably want two versions though:
1. One version for you to explore, try things, break things, etc. We'll call this your **Personal Repo** 
1. One version of the repo that your team will share.  We'll call this the **Team Repo**. 


### Setting Up Your Personal Repo

1. In GitHub, click the **fork** button in the upper right corner of the repo screen. 
1. When prompted, give the new repo a unique name, perhaps including your last name and the word 'personal'. 
1. Once the fork has been created, clone YOUR forked version of the repo to your computer. 
1. Set up the `.env` file in the `api` folder based on the `.env.template` file.
1. Start the docker containers. 

### Setting Up Your Team Repo 

Before you start: As a team, one person needs to assume the role of *Team Project Repo Owner*. 

1. The Team Project Repo Owner needs to fork this template repo into their own GitHub account **and give the repo a name consistent with your project's name**.  If you're worried that the repo is public, don't.  Every team is doing a different project. 
1. In the newly forked team repo, the Team Project Repo Owner should go to the **Settings** tab, choose **Collaborators and Teams** on the left-side panel. Add each of your team members to the repository with Write access. 
1. Each of the other team members will receive an invitation to join.  Obviously accept the invite. 
1. Once that process is complete, each team member, including the repo owner, should clone the Team's Repo to their local machines (in a different location than your Personal Project Repo).  

## Controlling the Containers

- `docker compose up -d` to start all the containers in the background
- `docker compose down` to shutdown and delete the containers
- `docker compose up db -d` only start the database container (replace db with the other services as needed)
- `docker compose stop` to "turn off" the containers but not delete them. 


## Handling User Role Access and Control

In most applications, when a user logs in, they assume a particular role.  For instance, when one logs in to a stock price prediction app, they may be a single investor, a portfolio manager, or a corporate executive (of a publicly traded company).  Each of those *roles* will likely present some similar features as well as some different features when compared to the other roles. So, how do you accomplish this in Streamlit?  This is sometimes called Role-based Access Control, or **RBAC** for short. 

The code in this project demonstrates how to implement a simple RBAC system in Streamlit but without actually using user authentication (usernames and passwords).  The Streamlit pages from the original template repo are split up among 3 roles - Political Strategist, USAID Worker, and a System Administrator role (this is used for any sort of system tasks such as re-training ML model, etc.). It also demonstrates how to deploy an ML model. 

Wrapping your head around this will take a little time and exploration of this code base.  Some highlights are below. 

### Getting Started with the RBAC 
1. We need to turn off the standard panel of links on the left side of the Streamlit app. This is done through the `app/src/.streamlit/config.toml` file.  So check that out. We are turning it off so we can control directly what links are shown. 
1. Then I created a new python module in `app/src/modules/nav.py`.  When you look at the file, you will se that there are functions for basically each page of the application. The `st.sidebar.page_link(...)` adds a single link to the sidebar. We have a separate function for each page so that we can organize the links/pages by role. 
1. Next, check out the `app/src/Home.py` file. Notice that there are 3 buttons added to the page and when one is clicked, it redirects via `st.switch_page(...)` to that Roles Home page in `app/src/pages`.  But before the redirect, I set a few different variables in the Streamlit `session_state` object to track role, first name of the user, and that the user is now authenticated.  
1. Notice near the top of `app/src/Home.py` and all other pages, there is a call to `SideBarLinks(...)` from the `app/src/nav.py` module.  This is the function that will use the role set in `session_state` to determine what links to show the user in the sidebar. 
1. The pages are organized by Role.  Pages that start with a `0` are related to the *Political Strategist* role.  Pages that start with a `1` are related to the *USAID worker* role.  And, pages that start with a `2` are related to The *System Administrator* role. 


## Deploying An ML Model (Totally Optional for CS3200 Project)

*Note*: This project only contains the infrastructure for a hypothetical ML model. 

1. Build, train, and test your ML model in a Jupyter Notebook. 
1. Once you're happy with the model's performance, convert your Jupyter Notebook code for the ML model to a pure python script.  You can include the `training` and `testing` functionality as well as the `prediction` functionality.  You may or may not need to include data cleaning, though. 
1. Check out the  `api/backend/ml_models` module.  In this folder, I've put a sample (read *fake*) ML model in `model01.py`.  The `predict` function will be called by the Flask REST API to perform '*real-time*' prediction based on model parameter values that are stored in the database.  **Important**: you would never want to hard code the model parameter weights directly in the prediction function.  tl;dr - take some time to look over the code in `model01.py`.  
1. The prediction route for the REST API is in `api/backend/customers/customer_routes.py`. Basically, it accepts two URL parameters and passes them to the `prediction` function in the `ml_models` module. The `prediction` route/function packages up the value(s) it receives from the model's `predict` function and send its back to Streamlit as JSON. 
1. Back in streamlit, check out `app/src/pages/11_Prediction.py`.  Here, I create two numeric input fields.  When the button is pressed, it makes a request to the REST API URL `/c/prediction/.../...` function and passes the values from the two inputs as URL parameters.  It gets back the results from the route and displays them. Nothing fancy here. 

 
