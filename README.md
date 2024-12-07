# Co-Op Cribs

Co-Op Cribs helps Northeastern University students find sublets while on co-op placements. The app connects students leaving their apartments with others in need of temporary housing, making the process of finding a sublet easy and efficient.

Team Members: 
- Ketul Kapadia 
- Arav Goyal
- Cathreen Paul
- Arnav Mishra
- Janvi Lingaiah

## Getting the WebPage Started 

Before starting the Docker containers, you need to configure your environment variables. Navigate to the .env file in the root directory of the project and ensure  the following configuration:
- SECRET_KEY: Used for securing sessions and cryptographic operations.
- DB_USER: MySQL username (typically root).
- DB_HOST: The database container's hostname (db).
- DB_PORT: The port for the MySQL database (default is 3306).
- DB_NAME: The name of the database (coopCribs)
- MYSQL_ROOT_PASSWORD: The root password for the MySQL database.

Now, before interacting with the web app, ensure that Docker containers are running. This is necessary to start the Streamlit app, Flask API, and MySQL database.

To start the containers, run the following in the project directory:
'docker compose up'.

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
<img width="1010" alt="Screen Shot 2024-12-05 at 5 57 47 PM" src="https://github.com/user-attachments/assets/277f8f22-8d68-487c-8af2-b828270973ef">


## Elizabeth's Housing Coordinator Page 
When the Housing Coordinator has been selected you will be navigated to the Housing Coordinator page, which offers a few actionables things:

### Sidebar Navigation:
When you open this page on the side bar as well as on the housing coordinator page there will be navigation links to go through:

- Dashboards: Access detailed dashboards for housing data and analytics for the housing.
- Users: View all registered users (students).
- Update Listing: Manage housing listings by updating available sublets.
- Delete Listing: Remove listings that are no longer available.
- Recent Listings: View recently posted housing options.
- About: Information about the app and its purpose.
- Logout: Sign out of your current session.
<img width="1139" alt="Screen Shot 2024-12-05 at 2 42 06 PM" src="https://github.com/user-attachments/assets/0c764844-6493-46ff-8146-03114abfa8e9">


## Leah's Student Dashboard:   
When you log in as a Student (e.g., Leah), you are directed to the Student Home page, which is designed to streamline the subletting process. On this page, you will see the following options:

### Sidebar Navigation:
When you open this page on the side bar as well as on the student dashboard page there will be navigation links to go through:

- Manage Your Listing: Allows you to manage and update your sublet listing, ensuring it's up-to-date for potential subletters.
- Find and Connect with Subletters: Enables you to search for available sublets, view listings, and reach out to potential subletters.
- View Subletter Reviews & Matches: Gives you access to reviews from previous subletters and shows how well you match with others looking for a sublet.
- About: Provides information about the app and its purpose.
- Logout: Allows you to log out of the current session.
<img width="1138" alt="Screen Shot 2024-12-05 at 3 27 27 PM" src="https://github.com/user-attachments/assets/0e4d26a8-db1a-4592-8b70-65fa408bd591">



##  Ramesh's Student Dashboard:  
When you log in as a Student (e.g., Ramesh), you are directed to the Student Home page, where you can perform the following actions:

### Sidebar Navigation:
When you open this page on the side bar as well as on the student dashboard page there will be navigation links to go through:

- Check my messages: View and manage messages from other users or potential subletters.
- Check Listings: Browse available sublets to find a place that suits your needs.
- Find events near me: Discover events happening in your area while you're on your co-op.
- Find potential room mates: Search for roommates that may fit your living preferences and co-op schedule.
- Check out neighborhoods: Explore different neighborhoods to decide where you'd like to live.
- About: Provides information about the app and its purpose.
- Logout: Allows you to log out of the current session.
<img width="1021" alt="Screen Shot 2024-12-05 at 6 01 09 PM" src="https://github.com/user-attachments/assets/2466d843-21ef-440a-8e75-45bc540c1a91">


##  Sanay's Investor Dashboard:  
When logging in as an Investor (e.g., Sanay), you’ll be taken to the Investor Home page, which offers the following options:

### Sidebar Navigation:
When you open this page on the side bar as well as on the investor dashboard page there will be navigation links to go through:

- Reviews: Access detailed reviews left by subletters.
- Analytics: View key metrics and data related to housing trends and performance.
- Messaging: Check and send messages to other users on the platform.
- About: Information about the app and its purpose.
- Logout: Log out of the current session.
<img width="1143" alt="Screen Shot 2024-12-05 at 3 44 23 PM" src="https://github.com/user-attachments/assets/0950cc9b-29cb-42e0-ac0a-99f5d8d6d4e8">

## Settled 
Once you are finally settled with your match or updated your listing and it is time to close the webpage, dont forget to 'docker compose down' to shutdown and stop the containers. 

### Demo walk through:
https://drive.google.com/file/d/1OQDb1QCy42wiHpst-F-7qU3uzbwzahAZ/view?usp=drive_link


## Thanks for using Co-Op Cribs. Hope you found your match!
