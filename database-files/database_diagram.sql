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

-- reviews --
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(1, 5, 1, 2, '2024-01-01 12:30:00', 'Great experience, very responsive and friendly.', 9);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(2, 4, 2, 3, '2024-02-15 10:45:00', 'Nice to work with, but communication could improve.', 8);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(3, 5, 3, 4, '2024-03-01 14:30:00', 'Excellent cooperation, everything was smooth.', 10);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(4, 3, 4, 5, '2024-04-12 16:00:00', 'Decent experience, but could have been better.', 7);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(5, 4, 5, 6, '2024-05-01 09:00:00', 'Good interaction, would recommend.', 8);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(6, 2, 6, 7, '2024-06-10 11:30:00', 'Not very responsive, had some issues.', 6);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(7, 5, 7, 8, '2024-07-20 13:30:00', 'Amazing! Everything was perfect, would rent again.', 10);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(8, 4, 8, 9, '2024-08-05 15:00:00', 'Great stay, just needed a bit more space.', 9);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(9, 3, 9, 10, '2024-09-15 18:00:00', 'Average experience, had some trouble with communication.', 7);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(10, 5, 10, 11, '2024-10-01 19:00:00', 'Everything was perfect, would definitely recommend!', 10);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(11, 4, 11, 12, '2024-11-10 17:30:00', 'Good experience, minor issues with the payment.', 8);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(12, 2, 12, 13, '2024-12-01 14:30:00', 'Had several issues during the stay, not great.', 5);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(13, 5, 13, 14, '2025-01-05 16:00:00', 'Fantastic host, everything was as expected!', 10);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(14, 4, 14, 15, '2025-02-15 11:30:00', 'Good experience, communication was easy.', 8);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(15, 3, 15, 16, '2025-03-20 13:00:00', 'Not bad, but had some issues with the amenities.', 7);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(16, 5, 16, 17, '2025-04-10 10:30:00', 'Perfect stay! Very responsive and kind host.', 9);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(17, 4, 17, 18, '2025-05-01 09:00:00', 'Good experience, clean and comfortable.', 8);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(18, 3, 18, 19, '2025-06-10 12:00:00', 'Average experience, had some communication issues.', 6);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(19, 5, 19, 20, '2025-07-15 14:00:00', 'Couldn’t have asked for a better host. 10/10!', 10);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(20, 4, 20, 21, '2025-08-01 15:30:00', 'Great communication, some minor issues with cleanliness.', 8);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(21, 2, 21, 22, '2025-09-05 16:30:00', 'The stay was not as expected, several issues with the apartment.', 5);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(22, 5, 22, 23, '2025-10-10 17:00:00', 'Amazing experience, highly recommended!', 10);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(23, 4, 23, 24, '2025-11-01 18:00:00', 'Very comfortable stay, would stay again!', 9);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(24, 3, 24, 25, '2025-12-05 19:00:00', 'The experience was decent, but some areas need improvement.', 7);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(25, 5, 25, 26, '2026-01-10 20:30:00', 'Absolutely loved it, great communication and service!', 10);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(26, 4, 26, 27, '2026-02-15 09:30:00', 'Great experience overall, just needed more space.', 8);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(27, 3, 27, 28, '2026-03-20 12:30:00', 'Had some problems with the facilities, but overall okay.', 6);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(28, 5, 28, 29, '2026-04-25 11:00:00', 'Everything was perfect, definitely recommended!', 10);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(29, 4, 29, 30, '2026-05-15 13:00:00', 'Nice stay, but the Wi-Fi connection could have been better.', 8);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(30, 3, 30, 31, '2026-06-01 14:30:00', 'It was decent, but there were some issues with cleanliness.', 7);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(31, 5, 31, 32, '2026-07-10 15:30:00', 'Perfect host, everything was great, highly recommended!', 10);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(32, 4, 32, 33, '2026-08-05 16:00:00', 'Good experience overall, clean apartment but a little noisy.', 8);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(33, 3, 33, 34, '2026-09-15 17:30:00', 'Some issues with the heating system, but everything else was fine.', 7);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(34, 5, 34, 35, '2026-10-20 18:00:00', 'Excellent stay, host was very accommodating and responsive.', 9);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(35, 4, 35, 36, '2026-11-10 19:30:00', 'Nice apartment, some minor maintenance issues, but overall pleasant.', 8);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(36, 3, 36, 37, '2026-12-01 20:00:00', 'Decent stay, but there were issues with the Wi-Fi during my time.', 6);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(37, 5, 37, 38, '2027-01-15 14:00:00', 'Fantastic experience, highly recommend this place!', 10);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(38, 4, 38, 39, '2027-02-10 15:00:00', 'Great place to stay, just needed a bit more lighting in the bedroom.', 8);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(39, 5, 39, 40, '2027-03-05 16:30:00', 'Everything was perfect, I would love to stay again!', 10);
INSERT IGNORE INTO reviews (review_id, rating, reviewer_id, reviewee_id, date, content, safety_score) VALUES 
(40, 3, 40, 1, '2027-04-01 17:00:00', 'Good experience, but there were a few miscommunications regarding check-in times.', 7);

-- neighborhoods --
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(1, 'Downtown', 10000, 8, 'A bustling area with restaurants, shops, and nightlife. High population density and moderate safety.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(2, 'Old Town', 8000, 9, 'A historical district with cobblestone streets and museums. Known for its safety and charm.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(3, 'Greenwich Village', 12000, 7, 'An artistic neighborhood with cafes and boutiques. Can get crowded but offers a vibrant atmosphere.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(4, 'Harlem', 15000, 6, 'A culturally rich area known for its history and music scene. Safety can be a concern in certain spots.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(5, 'SoHo', 20000, 8, 'A trendy area with high-end shopping, art galleries, and restaurants. A popular spot for both tourists and locals.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(6, 'Brooklyn Heights', 7000, 9, 'A scenic neighborhood with great views of Manhattan and a quiet residential feel.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(7, 'Chinatown', 18000, 5, 'A densely packed area with great food and markets. Can be crowded and less safe at night.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(8, 'Upper East Side', 10000, 9, 'An affluent area with parks, museums, and luxury shopping. Very safe and family-friendly.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(9, 'Midtown', 22000, 7, 'A central business district with offices, hotels, and shops. Very busy but safe in well-lit areas.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(10, 'East Village', 15000, 6, 'A vibrant neighborhood with bars, clubs, and artistic spaces. Some areas can be sketchy at night.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(11, 'Fidi (Financial District)', 25000, 9, 'A financial hub with tall buildings and quick access to public transport. Safe and secure.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(12, 'NoHo', 14000, 8, 'A creative district with theaters and studios. Somewhat crowded but offers a unique vibe.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(13, 'Hell’s Kitchen', 16000, 7, 'A neighborhood with diverse dining options, great for young professionals. Can be a little noisy at night.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(14, 'Flatiron District', 17000, 8, 'A business district surrounded by parks and restaurants. High foot traffic but safe overall.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(15, 'Greenpoint', 8000, 6, 'A residential area in Brooklyn with many Polish immigrants. A bit isolated from major attractions.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(16, 'Williamsburg', 13000, 7, 'A hipster hotspot in Brooklyn known for its art galleries and nightlife. Some areas are safer than others.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(17, 'Coney Island', 2000, 8, 'A coastal neighborhood with famous beaches and amusement parks. Safe during the daytime, quieter at night.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(18, 'Astoria', 14000, 9, 'A diverse neighborhood with excellent food and cultural venues. Safe and family-friendly.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(19, 'Chelsea', 16000, 8, 'An upscale neighborhood with art galleries and trendy eateries. Safe and close to major attractions.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(20, 'Inwood', 6000, 7, 'A quiet neighborhood in upper Manhattan. Offers parks and is residential with a lower crime rate.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(21, 'Washington Heights', 14000, 6, 'A vibrant neighborhood with a strong sense of community. Some areas can feel unsafe at night.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(22, 'Upper West Side', 12000, 9, 'A family-friendly area with parks, museums, and theaters. Safe and upscale.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(23, 'Park Slope', 11000, 9, 'A quiet, residential area in Brooklyn known for its tree-lined streets and great schools.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(24, 'Jackson Heights', 18000, 6, 'A diverse neighborhood with excellent public transit access. Some areas are less safe.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(25, 'Carroll Gardens', 9000, 8, 'A charming Brooklyn neighborhood with small-town vibes and excellent food options.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(26, 'East Harlem', 15000, 5, 'A rapidly changing neighborhood with a mix of old and new. Safety can be a concern in some areas.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(27, 'Bushwick', 20000, 6, 'Known for its art scene and street art murals, but some areas are unsafe at night.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(28, 'Kips Bay', 11000, 8, 'A neighborhood with great shopping, dining, and easy access to public transportation.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(29, 'Bensonhurst', 13000, 7, 'A family-friendly neighborhood with strong community ties and easy access to the subway.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(30, 'Morningside Heights', 8000, 8, 'A peaceful area near Columbia University, offering green spaces and safety.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(31, 'Forest Hills', 7000, 9, 'A suburban feel with lots of parks and great schools. Quiet and safe.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(32, 'Sunset Park', 11000, 7, 'A diverse neighborhood with a mix of residential, commercial, and industrial spaces.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(33, 'Fort Greene', 12000, 8, 'A vibrant Brooklyn neighborhood with historical significance, parks, and easy access to subway.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(34, 'Bed-Stuy', 14000, 6, 'A neighborhood with a rich cultural history. Safety can vary from block to block.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(35, 'Red Hook', 7000, 6, 'A waterfront neighborhood known for its warehouses and artsy vibe. Somewhat isolated and less safe.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(36, 'Crown Heights', 13000, 7, 'A historic area with diverse communities. Safety varies, but new development is improving it.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(37, 'Williamsbridge', 11000, 8, 'A quieter residential area with good schools and green spaces.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(38, 'Flatlands', 10000, 7, 'A suburban neighborhood with low crime rates and a tight-knit community.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(39, 'Bay Ridge', 11000, 8, 'A waterfront neighborhood with a Mediterranean feel, popular for families and quieter living.');
INSERT IGNORE INTO neighborhoods (neighborhood_id, name, population_density, safety_travel, insights) VALUES
(40, 'Sheepshead Bay', 12000, 7, 'A coastal area with easy access to the beach and fishing opportunities. Some areas have higher crime rates.');


-- listings --
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(1, '2024-01-01 10:00:00', '2024-01-02 10:00:00', 1200, 'Cozy Apartment in Downtown', 'A small, well-lit apartment in the heart of Downtown. Great for young professionals.', 'Wi-Fi, AC, Pet-friendly', 85, 9, 'Downtown', 1, 1, 101, 'Main St', 'New York', 10001, true, 6); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(2, '2024-02-01 11:00:00', '2024-02-02 11:00:00', 1500, 'Spacious 2-Bedroom in Harlem', 'A spacious 2-bedroom apartment with beautiful views of the city.', 'Wi-Fi, Parking, Balcony', 90, 8, 'Harlem', 2, 2, 202, '5th Ave', 'New York', 10026, true, 8); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(3, '2024-03-01 12:00:00', '2024-03-02 12:00:00', 1100, 'Affordable Studio in Chinatown', 'An affordable studio in the heart of Chinatown, close to public transport.', 'Wi-Fi, Elevator, No Pets', 80, 7, 'Chinatown', 3, 3, 303, 'Chinatown St', 'New York', 10013, true, 5); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(4, '2024-04-01 14:00:00', '2024-04-02 14:00:00', 2000, 'Luxury Loft in SoHo', 'A high-end loft with modern finishes and open floor plans. Perfect for professionals.', 'Wi-Fi, Gym, Concierge Service', 95, 9, 'SoHo', 4, 4, 404, 'Broadway', 'New York', 10012, true, 12); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(5, '2024-05-01 16:00:00', '2024-05-02 16:00:00', 950, 'Affordable 1-Bedroom in Brooklyn Heights', 'A cozy 1-bedroom apartment in a quiet, residential neighborhood with easy subway access.', 'Wi-Fi, Parking, No Pets', 82, 8, 'Brooklyn Heights', 5, 5, 505, 'Heights Blvd', 'Brooklyn', 11201, true, 6); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(6, '2024-06-01 17:30:00', '2024-06-02 17:30:00', 1300, 'Charming Studio in Greenwich Village', 'A charming studio apartment in one of New York’s most iconic neighborhoods. Great for students or young professionals.', 'Wi-Fi, Heating, Pet-friendly', 85, 8, 'Greenwich Village', 6, 6, 606, 'West 4th St', 'New York', 10012, true, 7); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(7, '2024-07-01 10:30:00', '2024-07-02 10:30:00', 950, 'Cozy 1-Bedroom in East Village', 'Small 1-bedroom apartment located in the trendy East Village area. Close to bars, restaurants, and shops.', 'Wi-Fi, Elevator, No Pets', 80, 7, 'East Village', 7, 7, 707, 'Avenue A', 'New York', 10009, true, 5); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(8, '2024-08-01 13:00:00', '2024-08-02 13:00:00', 1600, 'Modern 2-Bedroom in Midtown', 'A beautiful 2-bedroom apartment with great views of the skyline. Convenient for professionals.', 'Wi-Fi, Parking, Gym', 88, 8, 'Midtown', 8, 8, 808, '6th Ave', 'New York', 10019, true, 9); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(9, '2024-09-01 14:30:00', '2024-09-02 14:30:00', 1200, 'Quaint 1-Bedroom in Upper East Side', 'Located in one of the safest and most desirable neighborhoods in Manhattan.', 'Wi-Fi, Heating, Pet-friendly', 86, 9, 'Upper East Side', 9, 9, 909, 'Park Ave', 'New York', 10128, true, 6); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(10, '2024-10-01 15:00:00', '2024-10-02 15:00:00', 2200, 'Penthouse in the Financial District', 'Luxury penthouse with a large terrace and sweeping views of the city. Ideal for executives.', 'Wi-Fi, Concierge Service, Pool', 92, 10, 'FiDi', 10, 10, 1010, 'Wall St', 'New York', 10005, true, 15); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(11, '2024-11-01 16:30:00', '2024-11-02 16:30:00', 850, 'Studio in Williamsburg', 'A small studio located in the artsy area of Brooklyn, surrounded by cafes and galleries.', 'Wi-Fi, AC, No Pets', 83, 7, 'Williamsburg', 11, 11, 1111, 'Bedford Ave', 'Brooklyn', 11211, true, 7); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(12, '2024-12-01 17:00:00', '2024-12-02 17:00:00', 1400, 'Bright 1-Bedroom in Brooklyn Heights', 'A bright, spacious 1-bedroom with views of the river. Close to subway and shops.', 'Wi-Fi, Heating, No Pets', 87, 8, 'Brooklyn Heights', 12, 12, 1212, 'Henry St', 'Brooklyn', 11201, true, 8); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(13, '2025-01-01 18:00:00', '2025-01-02 18:00:00', 1300, 'Spacious 2-Bedroom in Upper West Side', 'A spacious 2-bedroom apartment with modern finishes and great views.', 'Wi-Fi, Heating, Pet-friendly', 89, 8, 'Upper West Side', 13, 13, 1313, 'Amsterdam Ave', 'New York', 10024, true, 10);
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(14, '2025-02-01 19:30:00', '2025-02-02 19:30:00', 1600, 'Luxury 1-Bedroom in SoHo', 'A stylish 1-bedroom apartment located in a prime location in SoHo.', 'Wi-Fi, Gym, Concierge Service', 91, 9, 'SoHo', 14, 14, 1414, 'Prince St', 'New York', 10012, true, 11); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(15, '2025-03-01 13:30:00', '2025-03-02 13:30:00', 950, 'Affordable Studio in Midtown', 'A small but efficient studio in Midtown Manhattan. Close to major businesses.', 'Wi-Fi, AC, Elevator', 80, 7, 'Midtown', 15, 15, 1515, '6th Ave', 'New York', 10019, true, 6); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(16, '2025-04-01 14:00:00', '2025-04-02 14:00:00', 1800, 'Charming 1-Bedroom in Harlem', 'A well-maintained 1-bedroom in the heart of Harlem, with easy access to subways and cafes.', 'Wi-Fi, Elevator, Pet-friendly', 85, 8, 'Harlem', 16, 16, 1616, 'Malcolm X Blvd', 'New York', 10027, true, 7); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(17, '2025-05-01 13:00:00', '2025-05-02 13:00:00', 2000, 'Upscale 2-Bedroom in Brooklyn', 'A luxury 2-bedroom apartment in the heart of Brooklyn, with rooftop access.', 'Wi-Fi, Pool, Gym', 90, 9, 'Brooklyn', 17, 17, 1717, 'Nostrand Ave', 'Brooklyn', 11226, true, 12); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(18, '2025-06-01 12:00:00', '2025-06-02 12:00:00', 1100, 'Budget-Friendly Studio in Queens', 'Affordable studio with easy access to public transport and local shops.', 'Wi-Fi, Heating, No Pets', 75, 6, 'Queens', 18, 18, 1818, 'Roosevelt Ave', 'Queens', 11368, true, 6);
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(19, '2025-07-01 15:30:00', '2025-07-02 15:30:00', 2100, 'Elegant 2-Bedroom in Upper East Side', 'A stunning 2-bedroom apartment with modern appliances and a large living room.', 'Wi-Fi, Elevator, Balcony', 92, 9, 'Upper East Side', 19, 19, 1919, 'Madison Ave', 'New York', 10162, true, 13); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(20, '2025-08-01 13:00:00', '2025-08-02 13:00:00', 950, 'Compact Studio in Midtown', 'A cozy studio located in Midtown Manhattan, perfect for a young professional.', 'Wi-Fi, AC, Pet-friendly', 80, 7, 'Midtown', 20, 20, 2020, 'Broadway', 'New York', 10036, true, 5);
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(21, '2025-09-01 14:00:00', '2025-09-02 14:00:00', 1700, 'Sunny 1-Bedroom in Downtown', 'Bright 1-bedroom apartment with great natural light and city views.', 'Wi-Fi, Heating, Pet-friendly', 87, 8, 'Downtown', 21, 21, 2121, 'Elm St', 'New York', 10002, true, 10); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(22, '2025-10-01 15:00:00', '2025-10-02 15:00:00', 1800, 'Modern 2-Bedroom in Brooklyn Heights', 'A modern 2-bedroom with open space and close to great dining options.', 'Wi-Fi, AC, Gym', 90, 8, 'Brooklyn Heights', 22, 22, 2222, 'Montague St', 'Brooklyn', 11201, true, 12); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(23, '2025-11-01 13:00:00', '2025-11-02 13:00:00', 1300, 'Cozy Studio in Queens', 'A small, cozy studio with easy access to subways and local parks.', 'Wi-Fi, Heating, No Pets', 80, 7, 'Queens', 23, 23, 2323, 'Northern Blvd', 'Queens', 11372, true, 6); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(24, '2025-12-01 14:00:00', '2025-12-02 14:00:00', 1400, 'Spacious Loft in SoHo', 'A spacious loft with high ceilings and an industrial aesthetic.', 'Wi-Fi, Elevator, Gym', 88, 9, 'SoHo', 24, 24, 2424, 'Spring St', 'New York', 10013, true, 11); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(25, '2026-01-01 13:00:00', '2026-01-02 13:00:00', 950, 'Efficient Studio in Midtown', 'A small but efficient studio with close access to major business centers.', 'Wi-Fi, AC, No Pets', 82, 7, 'Midtown', 25, 25, 2525, '7th Ave', 'New York', 10001, true, 5); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(26, '2026-02-01 14:00:00', '2026-02-02 14:00:00', 1800, 'Stylish 1-Bedroom in the Village', 'A stylish 1-bedroom apartment located in the heart of Greenwich Village.', 'Wi-Fi, Heating, Pet-friendly', 89, 8, 'Greenwich Village', 26, 26, 2626, 'Bleecker St', 'New York', 10014, true, 9); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(27, '2026-03-01 13:00:00', '2026-03-02 13:00:00', 1200, 'Affordable 1-Bedroom in Harlem', 'A well-priced 1-bedroom in Harlem, close to cultural venues and parks.', 'Wi-Fi, Elevator, No Pets', 80, 7, 'Harlem', 27, 27, 2727, '125th St', 'New York', 10027, true, 6); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(28, '2026-04-01 12:00:00', '2026-04-02 12:00:00', 2000, '2-Bedroom Apartment in FiDi', 'A spacious 2-bedroom apartment with views of the financial district.', 'Wi-Fi, Parking, Gym', 91, 9, 'Financial District', 28, 28, 2828, 'Broadway', 'New York', 10005, true, 12); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(29, '2026-05-01 13:00:00', '2026-05-02 13:00:00', 1700, '1-Bedroom in Upper West Side', 'Spacious 1-bedroom with modern finishes in an upscale neighborhood.', 'Wi-Fi, AC, Pet-friendly', 88, 8, 'Upper West Side', 29, 29, 2929, 'Columbus Ave', 'New York', 10024, true, 10); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(30, '2026-06-01 14:00:00', '2026-06-02 14:00:00', 1600, 'Penthouse in SoHo', 'A luxury penthouse with panoramic views of the city and a large terrace.', 'Wi-Fi, Pool, Concierge Service', 92, 10, 'SoHo', 30, 30, 3030, 'Houston St', 'New York', 10014, true, 15); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(31, '2026-07-01 15:00:00', '2026-07-02 15:00:00', 1000, 'Studio in Williamsburg', 'Cozy studio in the heart of Williamsburg, ideal for a single person or couple.', 'Wi-Fi, Heating, No Pets', 80, 7, 'Williamsburg', 31, 31, 3131, 'Bedford Ave', 'Brooklyn', 11211, true, 6); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(32, '2026-08-01 13:30:00', '2026-08-02 13:30:00', 1250, '1-Bedroom in Upper East Side', 'Charming 1-bedroom with modern appliances and great access to public transit.', 'Wi-Fi, Heating, Pet-friendly', 82, 8, 'Upper East Side', 32, 32, 3232, 'York Ave', 'New York', 10128, true, 6); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(33, '2026-09-01 14:00:00', '2026-09-02 14:00:00', 2100, 'Elegant Loft in the Village', 'Stylish loft in Greenwich Village, perfect for creatives and professionals.', 'Wi-Fi, Gym, Concierge Service', 94, 10, 'Greenwich Village', 33, 33, 3333, 'Bleecker St', 'New York', 10014, true, 14); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(34, '2026-10-01 13:30:00', '2026-10-02 13:30:00', 1200, 'Affordable 2-Bedroom in Queens', 'Spacious 2-bedroom apartment in a family-friendly neighborhood in Queens.', 'Wi-Fi, Parking, Elevator', 85, 8, 'Queens', 34, 34, 3434, 'Astoria Blvd', 'Queens', 11370, true, 7); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(35, '2026-11-01 14:00:00', '2026-11-02 14:00:00', 1800, '1-Bedroom with a View in Midtown', 'A bright 1-bedroom apartment with a view of the skyline, perfect for city lovers.', 'Wi-Fi, AC, Elevator', 90, 9, 'Midtown', 35, 35, 3535, '8th Ave', 'New York', 10001, true, 8); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(36, '2026-12-01 15:00:00', '2026-12-02 15:00:00', 2000, 'Luxury 2-Bedroom in FiDi', 'A 2-bedroom apartment in the heart of the financial district with top-tier amenities.', 'Wi-Fi, Pool, Gym', 92, 10, 'FiDi', 36, 36, 3636, 'Wall St', 'New York', 10005, true, 12); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(37, '2027-01-01 13:30:00', '2027-01-02 13:30:00', 1100, 'Studio Near Central Park', 'A studio apartment just a few blocks from Central Park, perfect for outdoor enthusiasts.', 'Wi-Fi, Elevator, No Pets', 80, 7, 'Upper West Side', 37, 37, 3737, 'Central Park West', 'New York', 10024, true, 6); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(38, '2027-02-01 14:30:00', '2027-02-02 14:30:00', 1600, 'Spacious 1-Bedroom in Brooklyn Heights', 'A spacious 1-bedroom apartment with river views and easy access to Brooklyn Bridge.', 'Wi-Fi, Parking, Elevator', 88, 9, 'Brooklyn Heights', 38, 38, 3838, 'Clark St', 'Brooklyn', 11201, true, 10); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(39, '2027-03-01 13:30:00', '2027-03-02 13:30:00', 1700, '3-Bedroom in Upper East Side', 'Spacious 3-bedroom apartment with a fantastic view and large living space.', 'Wi-Fi, AC, Balcony', 90, 9, 'Upper East Side', 39, 39, 3939, '2nd Ave', 'New York', 10128, true, 12); 
INSERT IGNORE INTO listings (listing_id, created_at, updated_at, rent_amount, title, description, amenities, match_score, safety_rating, location, created_by, neighborhood_id, house_number, street, city, zipcode, verification_status, timeline) VALUES 
(40, '2027-04-01 14:00:00', '2027-04-02 14:00:00', 1500, 'Modern 2-Bedroom in Queens', 'A modern 2-bedroom apartment in a prime location of Queens, close to transport and parks.', 'Wi-Fi, Elevator, No Pets', 85, 8, 'Queens', 40, 40, 4040, 'Queens Blvd', 'Queens', 11375, true, 10);

-- message --
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(1, '2024-01-01 10:00:00', 1, 2, 'Hi, I am interested in your listing. Could you share more details?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(2, '2024-01-02 10:30:00', 2, 3, 'Thanks for reaching out! The apartment is available. Let me know if you have any questions.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(3, '2024-01-03 12:00:00', 3, 4, 'I have some questions about the rent. Is it negotiable?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(4, '2024-01-04 14:00:00', 4, 5, 'The rent is fixed, but I can offer some flexibility on the move-in date.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(5, '2024-01-05 16:30:00', 5, 6, 'I love the location of your apartment. When can I schedule a tour?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(6, '2024-01-06 17:00:00', 6, 7, 'The tour is scheduled for tomorrow at 3 PM. Let me know if that works for you.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(7, '2024-01-07 11:30:00', 7, 8, 'I’m interested in the lease terms. How long is the minimum lease period?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(8, '2024-01-08 13:00:00', 8, 9, 'The minimum lease period is 6 months. Let me know if you have any other questions.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(9, '2024-01-09 15:00:00', 9, 10, 'I’m looking for a pet-friendly apartment. Does your listing allow pets?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(10, '2024-01-10 16:00:00', 10, 11, 'Yes, pets are allowed with a small deposit. Let me know if you’re still interested.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(11, '2024-01-11 18:00:00', 11, 12, 'I’m looking for a quiet place to study. Is the apartment in a quiet area?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(12, '2024-01-12 20:00:00', 12, 13, 'Yes, the apartment is located in a residential area, so it’s quite peaceful.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(13, '2024-01-13 09:00:00', 13, 14, 'How’s the neighborhood in terms of safety and amenities?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(14, '2024-01-14 10:30:00', 14, 15, 'The neighborhood is safe, and there are plenty of shops, parks, and public transport nearby.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(15, '2024-01-15 12:00:00', 15, 16, 'I’m concerned about the noise levels. Is the apartment soundproofed?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(16, '2024-01-16 13:30:00', 16, 17, 'The apartment is relatively quiet, and there are noise-reducing features in place.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(17, '2024-01-17 15:00:00', 17, 18, 'Can you provide some photos of the inside of the apartment?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(18, '2024-01-18 16:30:00', 18, 19, 'Sure, I’ll send you the photos shortly. Let me know what else you need.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(19, '2024-01-19 18:00:00', 19, 20, 'I am considering a few options. Could you provide a discount for a longer lease?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(20, '2024-01-20 19:30:00', 20, 21, 'I can offer a small discount for leases longer than a year. Let me know if that works for you.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(21, '2024-01-21 10:00:00', 21, 22, 'When would be a good time for you to meet and discuss the details?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(22, '2024-01-22 11:00:00', 22, 23, 'How about tomorrow afternoon at 2 PM? Does that work for you?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(23, '2024-01-23 13:00:00', 23, 24, 'Perfect, I’ll see you tomorrow at 2 PM. Looking forward to it!'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(24, '2024-01-24 14:00:00', 24, 25, 'I’m interested in the apartment. Can we set up a tour for this weekend?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(25, '2024-01-25 16:00:00', 25, 26, 'Saturday works well for me. How about 1 PM?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(26, '2024-01-26 17:30:00', 26, 27, 'That works! See you Saturday at 1 PM. Excited to check out the place.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(27, '2024-01-27 19:00:00', 27, 28, 'Can you send me your availability for a tour this week?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(28, '2024-01-28 10:00:00', 28, 29, 'I am available on Wednesday and Friday afternoon. Let me know what works best for you.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(29, '2024-01-29 11:00:00', 29, 30, 'Friday at 2 PM works great. Looking forward to it!'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(30, '2024-01-30 12:30:00', 30, 31, 'Thanks for your patience. I’ve received your details and will process them soon.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(31, '2024-01-31 14:00:00', 31, 32, 'Let me know if you need any further documentation or info from my side.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(32, '2024-02-01 15:00:00', 32, 33, 'I’ll send the documents over later today. Thanks for your help!'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(33, '2024-02-02 16:30:00', 33, 34, 'I have a few more questions about the building’s amenities. Could you clarify?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(34, '2024-02-03 17:00:00', 34, 35, 'Certainly! The building has a fitness center, laundry on-site, and a rooftop lounge.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(35, '2024-02-04 18:00:00', 35, 36, 'Thanks for the clarification! I’ll get back to you soon with a decision.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(36, '2024-02-05 19:00:00', 36, 37, 'Let me know when you’ve made a decision. Happy to assist with any further questions.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(37, '2024-02-06 20:00:00', 37, 38, 'I’d like to move forward. What are the next steps?'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(38, '2024-02-07 21:00:00', 38, 39, 'I’ll prepare the lease agreement for you. I’ll send it over for review shortly.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(39, '2024-02-08 22:00:00', 39, 40, 'Looking forward to signing the lease. Please let me know if anything is needed from my side.'); 
INSERT IGNORE INTO message (message_id, created_at, sender_id, receiver_id, content) VALUES 
(40, '2024-02-09 23:00:00', 40, 1, 'Great! I’ll send over the contract tomorrow. Thank you for your patience.');

-- roomateMatches
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(1, 1, 2, 85, 'Music, Movies'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(2, 2, 3, 90, 'Technology, Basketball'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(3, 3, 4, 80, 'Art, Cooking'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(4, 4, 5, 88, 'Reading, Hiking'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(5, 5, 6, 75, 'Fitness, Photography'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(6, 6, 7, 92, 'Cooking, Music'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(7, 7, 8, 85, 'Sports, Technology'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(8, 8, 9, 80, 'Movies, Traveling'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(9, 9, 10, 90, 'Music, Hiking'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(10, 10, 11, 87, 'Fitness, Cooking'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(11, 11, 12, 80, 'Art, Technology'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(12, 12, 13, 78, 'Movies, Reading'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(13, 13, 14, 84, 'Cooking, Photography'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(14, 14, 15, 90, 'Running, Hiking'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(15, 15, 16, 76, 'Music, Sports'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(16, 16, 17, 85, 'Technology, Photography'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(17, 17, 18, 88, 'Fitness, Traveling'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(18, 18, 19, 90, 'Yoga, Reading'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(19, 19, 20, 79, 'Movies, Cooking'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(20, 20, 21, 82, 'Sports, Cooking'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(21, 21, 22, 80, 'Technology, Fitness'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(22, 22, 23, 91, 'Art, Hiking'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(23, 23, 24, 85, 'Music, Photography'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(24, 24, 25, 90, 'Yoga, Sports'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(25, 25, 26, 86, 'Art, Fitness'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(26, 26, 27, 92, 'Cooking, Technology'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(27, 27, 28, 84, 'Reading, Traveling'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(28, 28, 29, 88, 'Movies, Fitness'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(29, 29, 30, 91, 'Sports, Yoga'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(30, 30, 31, 87, 'Photography, Art'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(31, 31, 32, 90, 'Technology, Cooking'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(32, 32, 33, 85, 'Traveling, Yoga'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(33, 33, 34, 82, 'Fitness, Cooking'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(34, 34, 35, 91, 'Movies, Sports'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(35, 35, 36, 88, 'Photography, Technology'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(36, 36, 37, 89, 'Reading, Art'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(37, 37, 38, 82, 'Yoga, Hiking'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(38, 38, 39, 90, 'Movies, Technology'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(39, 39, 40, 84, 'Cooking, Yoga'); 
INSERT IGNORE INTO roommateMatches (match_id, user1, user2, compatability_score, shared_interests) VALUES 
(40, 40, 1, 86, 'Fitness, Traveling');

-- analyticsDashboard -- 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(1, 'Winter', 5, 'Safe', 'High demand expected in Q2', 1); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(2, 'Spring', 7, 'Safe', 'Moderate demand expected in Q3', 2); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(3, 'Summer', 3, 'Very Safe', 'High demand expected in Q1', 3); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(4, 'Fall', 6, 'Safe', 'Stable demand throughout the year', 4); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(5, 'Winter', 4, 'Safe', 'Moderate demand in Q4', 5); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(6, 'Spring', 8, 'Safe', 'High demand in Q3', 6); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(7, 'Summer', 2, 'Very Safe', 'Moderate demand expected in Q2', 7); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(8, 'Fall', 10, 'Safe', 'Low demand expected in Q1', 8); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(9, 'Winter', 9, 'Safe', 'Stable demand in Q2', 9); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(10, 'Spring', 5, 'Safe', 'High demand expected in Q3', 10); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(11, 'Summer', 12, 'Very Safe', 'Moderate demand expected in Q1', 11); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(12, 'Fall', 6, 'Safe', 'High demand expected in Q4', 12); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(13, 'Winter', 3, 'Very Safe', 'Low demand expected in Q2', 13); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(14, 'Spring', 10, 'Safe', 'Stable demand throughout the year', 14); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(15, 'Summer', 15, 'Safe', 'High demand in Q3', 15); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(16, 'Fall', 8, 'Safe', 'Moderate demand in Q1', 16); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(17, 'Winter', 4, 'Safe', 'Low demand expected in Q4', 17); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(18, 'Spring', 9, 'Safe', 'Stable demand in Q2', 18); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(19, 'Summer', 5, 'Very Safe', 'High demand in Q1', 19); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(20, 'Fall', 6, 'Safe', 'Moderate demand expected in Q2', 20); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(21, 'Winter', 7, 'Safe', 'Low demand expected in Q3', 21); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(22, 'Spring', 10, 'Safe', 'Stable demand throughout the year', 22); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(23, 'Summer', 12, 'Safe', 'Moderate demand expected in Q1', 23); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(24, 'Fall', 9, 'Safe', 'High demand expected in Q4', 24); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(25, 'Winter', 8, 'Safe', 'Low demand expected in Q1', 25); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(26, 'Spring', 5, 'Very Safe', 'Moderate demand in Q2', 26); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(27, 'Summer', 3, 'Very Safe', 'High demand expected in Q3', 27); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(28, 'Fall', 6, 'Safe', 'Moderate demand in Q2', 28); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(29, 'Winter', 4, 'Safe', 'High demand expected in Q4', 29); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(30, 'Spring', 7, 'Safe', 'Low demand expected in Q1', 30); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(31, 'Summer', 9, 'Safe', 'Stable demand throughout the year', 31); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(32, 'Fall', 10, 'Safe', 'High demand expected in Q3', 32); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(33, 'Winter', 6, 'Safe', 'Low demand in Q2', 33); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(34, 'Spring', 8, 'Safe', 'Moderate demand expected in Q1', 34); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(35, 'Summer', 5, 'Very Safe', 'High demand expected in Q4', 35); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(36, 'Fall', 9, 'Safe', 'Stable demand in Q3', 36); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(37, 'Winter', 3, 'Safe', 'Low demand expected in Q2', 37); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(38, 'Spring', 6, 'Safe', 'High demand expected in Q1', 38); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(39, 'Summer', 7, 'Very Safe', 'Moderate demand expected in Q3', 39); 
INSERT IGNORE INTO analyticsDashboard (dashboard_id, seasonal_trend, vacancy_rate, safety_flag, demand_forecast, neighborhood) VALUES 
(40, 'Fall', 10, 'Safe', 'Low demand expected in Q4', 40);

-- housing coordinator --
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(1, 'John', 'Doe', 'Housing Services', 1); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(2, 'Jane', 'Smith', 'Housing Services', 2); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(3, 'Alex', 'Johnson', 'Housing Services', 3); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(4, 'Emily', 'Williams', 'Housing Services', 4); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(5, 'Michael', 'Brown', 'Housing Services', 5); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(6, 'Sophia', 'Jones', 'Housing Services', 6); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(7, 'William', 'Garcia', 'Housing Services', 7); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(8, 'Olivia', 'Martinez', 'Housing Services', 8); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(9, 'Ethan', 'Rodriguez', 'Housing Services', 9); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(10, 'Ava', 'Martinez', 'Housing Services', 10); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(11, 'Isabella', 'Hernandez', 'Housing Services', 11); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(12, 'Liam', 'Lopez', 'Housing Services', 12); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(13, 'Mia', 'Gonzalez', 'Housing Services', 13); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(14, 'Noah', 'Wilson', 'Housing Services', 14); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(15, 'Zoe', 'Anderson', 'Housing Services', 15); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(16, 'Lucas', 'Thomas', 'Housing Services', 16); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(17, 'Ella', 'Jackson', 'Housing Services', 17); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(18, 'Jackson', 'White', 'Housing Services', 18); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(19, 'Grace', 'Martinez', 'Housing Services', 19); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(20, 'Benjamin', 'Rodriguez', 'Housing Services', 20); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(21, 'Harper', 'Brown', 'Housing Services', 21); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(22, 'Daniel', 'Williams', 'Housing Services', 22); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(23, 'Lily', 'Jones', 'Housing Services', 23); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(24, 'Samuel', 'Davis', 'Housing Services', 24); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(25, 'Madeline', 'Martinez', 'Housing Services', 25); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(26, 'Sebastian', 'Hernandez', 'Housing Services', 26); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(27, 'Chloe', 'Lopez', 'Housing Services', 27); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(28, 'Charlotte', 'White', 'Housing Services', 28); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(29, 'Amelia', 'Harris', 'Housing Services', 29); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(30, 'Aiden', 'Taylor', 'Housing Services', 30); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(31, 'Mason', 'Martin', 'Housing Services', 31); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(32, 'Evan', 'Lewis', 'Housing Services', 32); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(33, 'Henry', 'Young', 'Housing Services', 33); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(34, 'Isaac', 'King', 'Housing Services', 34); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(35, 'Jack', 'Scott', 'Housing Services', 35); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(36, 'Leah', 'Adams', 'Housing Services', 36); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(37, 'Samuel', 'Baker', 'Housing Services', 37); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(38, 'Matthew', 'Gonzalez', 'Housing Services', 38); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(39, 'Ethan', 'Nelson', 'Housing Services', 39); 
INSERT IGNORE INTO housingCoordinator (coordinator_id, first_name, last_name, department, managed_listings) VALUES 
(40, 'Noah', 'Perez', 'Housing Services', 40);

-- events -- 
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(1, 'Welcome Back Party', '2024-01-01', 'University Hall', '10001', 'A fun gathering to kick off the new semester!', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(2, 'Tech Talk: Innovations in AI', '2024-02-10', 'Tech Auditorium', '10002', 'A seminar on the latest advancements in AI.', 'Tech Enthusiasts', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(3, 'Career Fair', '2024-03-15', 'Career Center', '10003', 'An event connecting students with top employers.', 'Students, Employers', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(4, 'Global Perspectives on Sustainability', '2024-04-01', 'Global Studies Building', '10004', 'Panel discussion on global sustainability efforts.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(5, 'Student Talent Show', '2024-05-05', 'Main Auditorium', '10005', 'A night to showcase student talent and creativity!', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(6, 'Tech Expo', '2024-06-20', 'Tech Expo Hall', '10006', 'An exhibition featuring the latest in tech innovation.', 'Tech Professionals, Students', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(7, 'Networking Night', '2024-07-10', 'University Lobby', '10007', 'A chance to network with professionals in your field.', 'Students, Alumni', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(8, 'Wellness Day', '2024-08-15', 'Student Center', '10008', 'A day dedicated to promoting physical and mental wellness.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(9, 'Hackathon 2024', '2024-09-30', 'Innovation Lab', '10009', '24-hour hackathon to solve real-world problems.', 'Students, Developers', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(10, 'International Food Festival', '2024-10-10', 'Campus Green', '10010', 'A celebration of global cuisine and culture.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(11, 'Environmental Clean-Up Drive', '2024-11-05', 'City Park', '10011', 'Join us for a day of environmental service and fun!', 'Students, Faculty, Community', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(12, 'Poetry Slam', '2024-12-01', 'Art Gallery', '10012', 'A night of creative expression through poetry.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(13, 'Annual Charity Run', '2025-01-15', 'City Center', '10013', 'Support local charities while getting fit!', 'Students, Faculty, Community', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(14, 'Art & Design Exhibition', '2025-02-01', 'Art Studio', '10014', 'A display of student artwork and design projects.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(15, 'Music Festival', '2025-03-20', 'Outdoor Stage', '10015', 'A music festival featuring student and local bands.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(16, 'Campus Clean-Up Day', '2025-04-10', 'Campus Grounds', '10016', 'Join us to clean up our campus and make it greener.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(17, 'Startup Pitch Event', '2025-05-05', 'Business Center', '10017', 'A pitch event for aspiring entrepreneurs.', 'Students, Entrepreneurs', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(18, 'Coding Bootcamp', '2025-06-15', 'Innovation Lab', '10018', 'Learn to code in a weekend with expert mentors.', 'Students, Developers', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(19, 'Virtual Career Workshop', '2025-07-20', 'Online', '10019', 'A virtual workshop to help students navigate career opportunities.', 'Students', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(20, 'International Student Meetup', '2025-08-01', 'Student Lounge', '10020', 'A meetup for international students to network and share experiences.', 'International Students', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(21, 'Outdoor Movie Night', '2025-09-05', 'Campus Lawn', '10021', 'Watch a classic movie under the stars.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(22, 'Mindfulness Workshop', '2025-10-01', 'Wellness Center', '10022', 'Learn mindfulness techniques to manage stress and improve focus.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(23, 'Science Fair', '2025-11-10', 'Science Building', '10023', 'Showcase of scientific projects by students and faculty.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(24, 'Annual Food Drive', '2025-12-05', 'Student Center', '10024', 'Donate food to help those in need during the holiday season.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(25, 'Robotics Competition', '2026-01-15', 'Engineering Lab', '10025', 'Compete with teams from across the region in a robotics challenge.', 'Students, Tech Enthusiasts', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(26, 'Career Mentorship Program', '2026-02-10', 'Career Center', '10026', 'Connect with alumni for career guidance and advice.', 'Students, Alumni', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(27, 'Guest Speaker Series: Sustainability', '2026-03-01', 'Auditorium', '10027', 'A lecture on sustainable practices and innovations.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(28, 'Open Mic Night', '2026-04-15', 'Student Union', '10028', 'A chance for students to showcase their talents, from music to comedy.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(29, 'Coding Challenge', '2026-05-20', 'Innovation Hub', '10029', 'A challenge where students solve coding problems in teams.', 'Students, Developers', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(30, 'Fitness Challenge', '2026-06-10', 'Gymnasium', '10030', 'A fitness challenge to promote a healthy lifestyle among students.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(31, 'Diversity Conference', '2026-07-05', 'Conference Center', '10031', 'A conference focusing on diversity and inclusion in the workplace.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(32, 'Leadership Summit', '2026-08-01', 'Student Center', '10032', 'A summit to inspire and develop leadership skills among students.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(33, 'Tech Startup Week', '2026-09-20', 'Innovation Lab', '10033', 'Workshops and talks by successful tech entrepreneurs.', 'Students, Entrepreneurs', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(34, 'Charity Auction', '2026-10-01', 'Campus Lounge', '10034', 'A fundraising auction to support local charities.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(35, 'Film Festival', '2026-11-15', 'Film Hall', '10035', 'A showcase of student films and documentaries.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(36, 'Annual Conference on Education', '2026-12-05', 'Conference Center', '10036', 'An educational conference on current trends in teaching and learning.', 'Educators, Students', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(37, 'Photography Workshop', '2027-01-25', 'Art Studio', '10037', 'A workshop to enhance your photography skills.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(38, 'Cultural Diversity Celebration', '2027-02-15', 'Student Center', '10038', 'Celebrate cultural diversity through performances and food.', 'Students, Faculty', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(39, 'Community Health Fair', '2027-03-10', 'Campus Green', '10039', 'A health fair promoting wellness and healthy living.', 'Students, Faculty, Community', 'Northeastern University');
INSERT IGNORE INTO events (events_id, name, event_date, loc, zipcode, description, target_audience, event_host) VALUES 
(40, 'Art Gala', '2027-04-01', 'Art Gallery', '10040', 'A gala to raise funds for art scholarships and grants.', 'Students, Faculty, Alumni', 'Northeastern University');
-- 