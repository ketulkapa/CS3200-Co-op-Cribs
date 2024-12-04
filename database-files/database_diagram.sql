DROP DATABASE IF EXISTS coopCribs;
CREATE DATABASE IF NOT EXISTS coopCribs;
USE coopCribs;

CREATE TABLE IF NOT EXISTS users (
  user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  role VARCHAR(100) NOT NULL,
  phone_number CHAR(20) NOT NULL,
  coop_timeline VARCHAR(255),
  budget VARCHAR(255),
  housing_status VARCHAR(255),
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  urgency VARCHAR(100),
  interests TEXT,
  university VARCHAR(255),
  age INTEGER,
  preferred_location VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS reviews (
  review_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  rating INTEGER NOT NULL ,
  reviewer_id INTEGER NOT NULL,
  reviewee_id INTEGER NOT NULL,
  date TIMESTAMP,
  content TEXT,
  safety_score INTEGER,
  FOREIGN KEY (reviewer_id) REFERENCES users(user_id),
  FOREIGN KEY (reviewee_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS neighborhoods (
  neighborhood_id INTEGER PRIMARY KEY auto_increment,
  name VARCHAR(255) NOT NULL ,
  population_density INTEGER,
  safety_travel INTEGER,
  insights TEXT
);

CREATE TABLE IF NOT EXISTS listings (
  listing_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      ON UPDATE CURRENT_TIMESTAMP,
  rent_amount INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  amenities TEXT,
  match_score INTEGER,
  safety_rating INTEGER,
  location VARCHAR(255) NOT NULL,
  created_by INTEGER,
  neighborhood_id INTEGER,
  house_number INTEGER NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  zipcode INTEGER NOT NULL,
  verification_status BOOLEAN NOT NULL,
  timeline INTEGER,
  FOREIGN KEY (created_by) REFERENCES users(user_id),
  FOREIGN KEY (neighborhood_id) REFERENCES neighborhoods(neighborhood_id)
);

CREATE TABLE IF NOT EXISTS message (
  message_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  created_at TIMESTAMP,
  sender_id INTEGER,
  receiver_id INTEGER,
  content TEXT NOT NULL,
  FOREIGN KEY (sender_id) REFERENCES users(user_id),
  FOREIGN KEY (receiver_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS roommateMatches (
  match_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  user1 INTEGER,
  user2 INTEGER,
  compatability_score INTEGER,
  shared_interests VARCHAR(255),
  FOREIGN KEY (user1) REFERENCES users(user_id),
  FOREIGN KEY (user2) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS analyticsDashboard (
  dashboard_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  seasonal_trend VARCHAR(255) ,
  vacancy_rate INTEGER,
  safety_flag VARCHAR(255),
  demand_forecast VARCHAR(255),
  neighborhood INTEGER ,
  FOREIGN KEY (neighborhood) REFERENCES neighborhoods(neighborhood_id)
);

CREATE TABLE IF NOT EXISTS housingCoordinator (
  coordinator_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  department VARCHAR(255) NOT NULL,
  managed_listings INTEGER,
  FOREIGN KEY (managed_listings) REFERENCES listings(listing_id)
);

CREATE TABLE IF NOT EXISTS coordinatorDashboardAccess (
    coordinator_id INTEGER,
    dashboard_id INTEGER,
    PRIMARY KEY (coordinator_id, dashboard_id),
    FOREIGN KEY (coordinator_id) REFERENCES housingCoordinator(coordinator_id),
    FOREIGN KEY (dashboard_id) REFERENCES analyticsDashboard(dashboard_id)
);

CREATE TABLE IF NOT EXISTS coordinatorManagedListings (
    coordinator_id INTEGER,
    listing_id INTEGER,
    PRIMARY KEY (coordinator_id, listing_id),
    FOREIGN KEY (coordinator_id) REFERENCES housingCoordinator(coordinator_id),
    FOREIGN KEY (coordinator_id) REFERENCES listings(listing_id)
);

CREATE TABLE IF NOT EXISTS events (
    events_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,               -- Name of the event
    event_date TEXT NOT NULL,         -- Date and time of the event
    loc TEXT NOT NULL,                -- Location of the event
    description TEXT,                 -- A description of the event
    target_audience TEXT,            -- Target audience (e.g., Northeastern students, co-op workers)
    event_host TEXT,                  -- Organizer/Host of the event
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Timestamp for when the event was created
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP   -- Timestamp for when the event was last updated
);


INSERT IGNORE INTO users (role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location)
VALUES
('Student', '555-1234', 'Fall 2024 - Spring 2025', '1000-1500', 'Looking for a subletter', 'John', 'Doe', 'john.doe@email.com', 'High', 'Technology, Sports', 'Northeastern University', 21, 'Boston'),
('Student', '555-5678', 'Summer 2024', '1200-1800', 'Looking for a roommate', 'Jane', 'Smith', 'jane.smith@email.com', 'Medium', 'Music, Reading', 'Northeastern University', 22, 'Cambridge');

INSERT IGNORE INTO reviews (rating, reviewer_id, reviewee_id, date, content, safety_score)
VALUES
(5, 1, 2, '2024-11-01 10:30:00', 'Great roommate, very clean and organized.', 8),
(4, 2, 1, '2024-11-05 15:45:00', 'Friendly and respectful, highly recommend!', 9);

INSERT IGNORE INTO message (created_at, sender_id, receiver_id, content)
VALUES
('2024-11-30 14:00:00', 1, 2, 'Hey Jane, I’m interested in your apartment listing.'),
('2024-12-01 09:15:00', 2, 1, 'Hi John, the listing is still available. Let’s connect!');

INSERT IGNORE INTO roommateMatches (user1, user2, compatability_score, shared_interests)
VALUES
(1, 2, 88, 'Music, Sports'),
(2, 1, 92, 'Reading, Technology');

INSERT IGNORE INTO neighborhoods (name, population_density, safety_travel, insights)
VALUES
('Fenway', 12000, 4, 'Great for students, close to universities. Safe and vibrant area.'),
('Back Bay', 8000, 5, 'Upscale area with beautiful architecture and excellent dining options.');

INSERT IGNORE INTO listings (rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline)
VALUES
(1500, 'Spacious Apartment in Boston', '2-bedroom apartment close to campus', 'WiFi, Heating, Laundry', 85, 7, 'Boston', 1, 1, 123, 'Main Street', 'Boston', 02115, TRUE, 6),
(1800, 'Cozy Cambridge Studio', 'Studio apartment with great amenities', 'AC, Parking, Gym Access', 78, 8, 'Cambridge', 2, 2, 456, 'Elm Street', 'Cambridge', 02138, FALSE, 3);

INSERT IGNORE INTO analyticsDashboard (seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood)
VALUES
('Fall', 5, 'Green', 'High', 1),
('Winter', 3, 'Yellow', 'Medium', 2);

INSERT IGNORE INTO housingCoordinator (first_name, last_name, department)
VALUES
('Alice', 'Johnson', 'Housing'),
('Bob', 'Williams', 'Housing');

INSERT IGNORE INTO coordinatorDashboardAccess (coordinator_id, dashboard_id)
VALUES
    (1, 1),
    (1, 2);

INSERT INTO coordinatorManagedListings (coordinator_id, listing_id)
VALUES
    (1, 1),
    (1, 2);