DROP DATABASE IF EXISTS coopCribs;
CREATE DATABASE IF NOT EXISTS coopCribs;
USE coopCribs;

-- DDL --


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
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
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

CREATE TABLE IF NOT EXISTS events (
    events_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name TEXT NOT NULL,               
    event_date TEXT NOT NULL,         
    loc TEXT NOT NULL,
    zipcode varchar(15) NOT NULL,                
    description TEXT,                 
    target_audience TEXT,            
    event_host TEXT                 
);

-- Insert data into users
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location)
VALUES
('U000001', 'Student', '555-1234', 'Fall 2024 - Spring 2025', '1000-1500', 'Looking for a subletter', 'John', 'Doe', 'john.doe@email.com', 'High', 'Technology, Sports', 'Northeastern University', 21, 'Boston'),
('U000002', 'Student', '555-5678', 'Summer 2024', '1200-1800', 'Looking for a roommate', 'Jane', 'Smith', 'jane.smith@email.com', 'Medium', 'Music, Reading', 'Northeastern University', 22, 'Cambridge');

-- Insert data into reviews
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score)
VALUES
(1, 5, 'U000001', 'U000002', '2024-11-01 10:30:00', 'Great roommate, very clean and organized.', 8),
(2, 4, 'U000002', 'U000001', '2024-11-05 15:45:00', 'Friendly and respectful, highly recommend!', 9);

-- Insert data into neighborhoods
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights)
VALUES
(1, 'Fenway', 12000, 4, 'Great for students, close to universities. Safe and vibrant area.'),
(2, 'Back Bay', 8000, 5, 'Upscale area with beautiful architecture and excellent dining options.');

-- Insert data into listings
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline)
VALUES
(1, '2024-04-01 08:30:00', '2024-04-01 08:30:00', 1500, 'Cozy 2BR Apartment', 'A comfortable two-bedroom apartment near campus.', 'WiFi, Laundry', 85, 4, 'Fenway', 'U000001', 1, 123, 'Main Street', 'Boston', 02115, TRUE, 6),
(2, '2024-05-01 09:00:00', '2024-05-01 09:00:00', 1800, 'Spacious Studio', 'A spacious studio apartment in Back Bay.', 'AC, Parking', 90, 5, 'Back Bay', 'U000002', 2, 456, 'Elm Street', 'Boston', 02116, FALSE, 12);

-- Insert data into message
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content)
VALUES
(1, '2024-04-05 14:00:00', 'U000001', 'U000002', 'Hi, I’m interested in your apartment listing. Can you provide more details?'),
(2, '2024-04-06 15:30:00', 'U000002', 'U000001', 'Sure! The apartment has a great view and is very close to campus.');

-- Insert data into roommateMatches
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests)
VALUES
(1, 'U000001', 'U000002', 88, 'Music, Sports'),
(2, 'U000002', 'U000001', 92, 'Reading, Technology');

-- Insert data into analyticsDashboard
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood)
VALUES
(1, 'Fall', 5, 'Green', 'High', 1),
(2, 'Winter', 3, 'Yellow', 'Medium', 2);

-- Insert data into housingCoordinator
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings)
VALUES
(1, 'Alice', 'Johnson', 'Housing', 1),
(2, 'Bob', 'Williams', 'Student Affairs', 2);

-- Insert data into events
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host)
VALUES
(1, 'Apartment Fair', '2024-06-01', 'Fenway', '02115', 'Find your perfect apartment.', 'Students', 'Northeastern University'),
(2, 'Roommate Meet-up', '2024-07-15', 'Back Bay', '02116', 'Meet potential roommates.', 'Students and Professionals', 'Housing Association');




-- Sample Data --

-- users --
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(1, 'Student', '987-654-3210', 'Jan 2024 - May 2024', '800-1000 USD', 'Looking for sublet', 'Emily', 'Johnson', 'emilyjohnson@example.com', 'High', 'Reading, Hiking', 'University of Texas', 19, 'Austin, TX');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(2, 'Student', '987-654-3211', 'Jun 2024 - Dec 2024', '600-800 USD', 'Looking for sublet', 'Sophia', 'Garcia', 'sophiagarcia@example.com', 'Medium', 'Travel, Painting', 'University of California, Berkeley', 20, 'Berkeley, CA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(3, 'Student', '987-654-3212', 'Feb 2024 - Aug 2024', '700-900 USD', 'Looking for sublet', 'Jacob', 'Martinez', 'jacobmartinez@example.com', 'High', 'Photography, Coding', 'University of Michigan', 22, 'Ann Arbor, MI');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(4, 'Student', '987-654-3213', 'Mar 2024 - Sept 2024', '1000-1200 USD', 'Looking for sublet', 'Isabella', 'Lee', 'isabellalee@example.com', 'Low', 'Dancing, Sports', 'Harvard University', 21, 'Cambridge, MA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(5, 'Student', '987-654-3214', 'Jan 2024 - May 2024', '500-700 USD', 'Looking for sublet', 'Liam', 'Anderson', 'liamanderson@example.com', 'Medium', 'Music, Sports', 'Yale University', 19, 'New Haven, CT');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(6, 'Student', '987-654-3215', 'Jun 2024 - Dec 2024', '800-1000 USD', 'Looking for sublet', 'Ava', 'Martinez', 'avamartinez@example.com', 'Low', 'Art, Cooking', 'Stanford University', 20, 'Stanford, CA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(7, 'Student', '987-654-3216', 'Feb 2024 - Aug 2024', '700-900 USD', 'Looking for sublet', 'Ethan', 'Hernandez', 'ethanhernandez@example.com', 'High', 'Running, Reading', 'Princeton University', 22, 'Princeton, NJ');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(8, 'Student', '987-654-3217', 'Mar 2024 - Sept 2024', '600-800 USD', 'Looking for sublet', 'Charlotte', 'Taylor', 'charlottetaylor@example.com', 'High', 'Writing, Hiking', 'University of Washington', 21, 'Seattle, WA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(9, 'Student', '987-654-3218', 'Jan 2024 - May 2024', '800-1000 USD', 'Looking for sublet', 'Mason', 'Brown', 'masonbrown@example.com', 'Medium', 'Photography, Music', 'Massachusetts Institute of Technology', 19, 'Cambridge, MA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(10, 'Student', '987-654-3219', 'Jun 2024 - Dec 2024', '600-800 USD', 'Looking for sublet', 'Jackson', 'Wilson', 'jacksonwilson@example.com', 'Low', 'Technology, Gaming', 'University of Illinois', 20, 'Champaign, IL');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(11, 'Student', '987-654-3220', 'Feb 2024 - Aug 2024', '700-900 USD', 'Looking for sublet', 'Amelia', 'Davis', 'ameliadavis@example.com', 'High', 'Fitness, Reading', 'University of Chicago', 22, 'Chicago, IL');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(12, 'Student', '987-654-3221', 'Mar 2024 - Sept 2024', '1000-1200 USD', 'Looking for sublet', 'James', 'Miller', 'jamesmiller@example.com', 'Low', 'Tech, Gaming', 'University of Southern California', 23, 'Los Angeles, CA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(13, 'Student', '987-654-3222', 'Jan 2024 - May 2024', '500-700 USD', 'Looking for sublet', 'Harper', 'Clark', 'harperclark@example.com', 'Medium', 'Reading, Running', 'University of Florida', 19, 'Gainesville, FL');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(14, 'Student', '987-654-3223', 'Jun 2024 - Dec 2024', '800-1000 USD', 'Looking for sublet', 'Elijah', 'Rodriguez', 'elijahrodriguez@example.com', 'Low', 'Art, Yoga', 'Cornell University', 20, 'Ithaca, NY');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(15, 'Student', '987-654-3224', 'Feb 2024 - Aug 2024', '700-900 USD', 'Looking for sublet', 'Lily', 'Walker', 'lilywalker@example.com', 'High', 'Sports, Fitness', 'Duke University', 21, 'Durham, NC');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(16, 'Student', '987-654-3225', 'Mar 2024 - Sept 2024', '600-800 USD', 'Looking for sublet', 'Isaiah', 'Allen', 'isaiahallen@example.com', 'Medium', 'Gaming, Hiking', 'University of North Carolina', 22, 'Chapel Hill, NC');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(17, 'Student', '987-654-3226', 'Jan 2024 - May 2024', '800-1000 USD', 'Looking for sublet', 'Jackson', 'Moore', 'jacksonmoore@example.com', 'High', 'Sports, Coding', 'University of California, Los Angeles', 20, 'LA, CA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(18, 'Student', '987-654-3227', 'Jun 2024 - Dec 2024', '600-800 USD', 'Looking for sublet', 'Isabella', 'Scott', 'isabellascott@example.com', 'Medium', 'Travel, Reading', 'University of Pennsylvania', 21, 'Philadelphia, PA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(19, 'Student', '987-654-3228', 'Feb 2024 - Aug 2024', '700-900 USD', 'Looking for sublet', 'Lucas', 'Lee', 'lucaslee@example.com', 'High', 'Sports, Tech', 'University of California, San Diego', 22, 'San Diego, CA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(20, 'Student', '987-654-3229', 'Mar 2024 - Sept 2024', '1000-1200 USD', 'Looking for sublet', 'Madeline', 'King', 'madelineking@example.com', 'Low', 'Photography, Traveling', 'Columbia University', 23, 'New York, NY');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(21, 'Student', '987-654-3230', 'Jan 2024 - May 2024', '600-800 USD', 'Looking for sublet', 'Benjamin', 'Martin', 'benjaminmartin@example.com', 'Medium', 'Gaming, Music', 'University of Washington', 19, 'Seattle, WA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(22, 'Student', '987-654-3231', 'Jun 2024 - Dec 2024', '700-900 USD', 'Looking for sublet', 'Ava', 'Carter', 'avacarter@example.com', 'High', 'Art, Hiking', 'Northwestern University', 20, 'Evanston, IL');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(23, 'Student', '987-654-3232', 'Feb 2024 - Aug 2024', '800-1000 USD', 'Looking for sublet', 'Sophia', 'Nelson', 'sophianelson@example.com', 'Low', 'Cooking, Traveling', 'University of Virginia', 21, 'Charlottesville, VA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(24, 'Student', '987-654-3233', 'Mar 2024 - Sept 2024', '600-800 USD', 'Looking for sublet', 'Isaac', 'Baker', 'isaacbaker@example.com', 'High', 'Reading, Hiking', 'University of North Carolina', 20, 'Chapel Hill, NC');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(25, 'Student', '987-654-3234', 'Jan 2024 - May 2024', '500-700 USD', 'Looking for sublet', 'Charlotte', 'Moore', 'charlottemoore@example.com', 'Medium', 'Sports, Yoga', 'University of Miami', 19, 'Miami, FL');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(26, 'Student', '987-654-3235', 'Jun 2024 - Dec 2024', '800-1000 USD', 'Looking for sublet', 'Lily', 'Roberts', 'lilyroberts@example.com', 'Low', 'Photography, Music', 'Boston University', 20, 'Boston, MA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(27, 'Student', '987-654-3236', 'Feb 2024 - Aug 2024', '700-900 USD', 'Looking for sublet', 'Aiden', 'Parker', 'aidenparker@example.com', 'High', 'Tech, Gaming', 'Georgia Tech', 22, 'Atlanta, GA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(28, 'Student', '987-654-3237', 'Mar 2024 - Sept 2024', '600-800 USD', 'Looking for sublet', 'Mason', 'Cooper', 'masoncooper@example.com', 'Low', 'Reading, Painting', 'University of Wisconsin', 21, 'Madison, WI');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(29, 'Student', '987-654-3238', 'Jan 2024 - May 2024', '800-1000 USD', 'Looking for sublet', 'Grace', 'Young', 'graceyoung@example.com', 'Medium', 'Running, Cooking', 'Ohio State University', 20, 'Columbus, OH');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(30, 'Student', '987-654-3239', 'Jun 2024 - Dec 2024', '700-900 USD', 'Looking for sublet', 'Ella', 'Mitchell', 'ellamitchell@example.com', 'High', 'Dancing, Sports', 'University of Maryland', 19, 'College Park, MD');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(31, 'Student', '987-654-3240', 'Feb 2024 - Aug 2024', '600-800 USD', 'Looking for sublet', 'Owen', 'Green', 'owengreen@example.com', 'Low', 'Music, Traveling', 'Indiana University', 21, 'Bloomington, IN');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(32, 'Student', '987-654-3241', 'Mar 2024 - Sept 2024', '800-1000 USD', 'Looking for sublet', 'Sophie', 'Adams', 'sophieadams@example.com', 'Medium', 'Technology, Sports', 'University of Michigan', 23, 'Ann Arbor, MI');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(33, 'Student', '987-654-3242', 'Jan 2024 - May 2024', '600-800 USD', 'Looking for sublet', 'Ethan', 'Parker', 'ethanparker@example.com', 'High', 'Reading, Music', 'Harvard University', 19, 'Cambridge, MA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(34, 'Student', '987-654-3243', 'Jun 2024 - Dec 2024', '700-900 USD', 'Looking for sublet', 'Emily', 'Evans', 'emilyevans@example.com', 'Low', 'Running, Hiking', 'University of North Carolina', 20, 'Chapel Hill, NC');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(35, 'Student', '987-654-3244', 'Feb 2024 - Aug 2024', '800-1000 USD', 'Looking for sublet', 'Owen', 'Reed', 'owenreed@example.com', 'High', 'Gaming, Photography', 'University of Florida', 22, 'Gainesville, FL');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(36, 'Student', '987-654-3245', 'Mar 2024 - Sept 2024', '1000-1200 USD', 'Looking for sublet', 'Sophie', 'Adams', 'sophieadams@example.com', 'Medium', 'Technology, Sports', 'University of Michigan', 23, 'Ann Arbor, MI');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(37, 'Student', '987-654-3246', 'Jan 2024 - May 2024', '600-800 USD', 'Looking for sublet', 'Ethan', 'Parker', 'ethanparker@example.com', 'High', 'Reading, Music', 'Harvard University', 19, 'Cambridge, MA');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(38, 'Student', '987-654-3247', 'Jun 2024 - Dec 2024', '700-900 USD', 'Looking for sublet', 'Emily', 'Evans', 'emilyevans@example.com', 'Low', 'Running, Hiking', 'University of North Carolina', 20, 'Chapel Hill, NC');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(39, 'Student', '987-654-3248', 'Feb 2024 - Aug 2024', '800-1000 USD', 'Looking for sublet', 'Sophie', 'Brown', 'sophiebrown@example.com', 'High', 'Gaming, Photography', 'University of Florida', 22, 'Gainesville, FL');
INSERT IGNORE INTO users (user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) VALUES
(40, 'Student', '987-654-3249', 'Mar 2024 - Sept 2024', '600-800 USD', 'Looking for sublet', 'Liam', 'Scott', 'liamscott@example.com', 'Low', 'Music, Reading', 'Duke University', 21, 'Durham, NC');

-- 