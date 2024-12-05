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



-- Sample Data --

-- users --
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (1, 'Safety Technician III', '(518) 5106528', '', 1285.91, true, 'Bentlee', 'Gumn', 'bgumn0@aboutads.info', 'Drainage of L Low Femur with Drain Dev, Perc Endo Approach', null, 'Columbia University', 18, 'Ishëm');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (2, 'Compensation Analyst', '(115) 4879880', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.', 2636.3, true, 'Ruthe', 'Dyzart', 'rdyzart1@mozilla.org', 'Motor Function Treatment of Musculosk Low Back/LE', null, 'Eastern Michigan University', 23, 'Jian’ou');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (3, 'GIS Technical Architect', '(319) 8783937', '', 1985.0, true, 'Helenelizabeth', 'Lainton', 'hlainton2@abc.net.au', 'Removal of Intraluminal Device from Nose, Via Opening', null, 'Universitas Muhammadiyah Makassar', 22, 'Virginia');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (4, 'VP Accounting', '(490) 3372755', 'Duis mattis egestas metus. Aenean fermentum.', 2375.91, true, 'Theobald', 'Halton', 'thalton3@usnews.com', 'Introduce of Local Anesth into Spinal Canal, Perc Approach', null, 'Kyonggi University', 23, 'Opochka');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (5, 'VP Marketing', '(626) 1125153', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 1038.03, true, 'Dani', 'MacBarron', 'dmacbarron4@theglobeandmail.com', 'Removal of Autol Sub from Up Vein, Perc Endo Approach', null, 'University of the Philippines Diliman', 23, 'Cerrito');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (6, 'Senior Cost Accountant', '(972) 1132705', 'In est risus, auctor sed, tristique in, tempus sit amet, sem.', 2492.18, true, 'Vladimir', 'Deeman', 'vdeeman5@shutterfly.com', 'Remove Infusion Dev from L Metatarsotars Jt, Extern', null, 'National Institute of Technology Kurukshetra', 22, 'Lianjiangkou');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (7, 'Business Systems Development Analyst', '(980) 2840294', 'Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 2984.73, false, 'Leda', 'Brodway', 'lbrodway6@shareasale.com', 'MRI of Sella Tur/Pituitary using Oth Contrast', null, 'Fachhochschule Offenburg, Hochschule für Technik und Wirtschaft', 18, 'Renfrew');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (8, 'Automation Specialist I', '(846) 9108953', '', 2989.08, false, 'Mikael', 'Lackeye', 'mlackeye7@mail.ru', 'Supplement Esophagus with Autologous Tissue Substitute, Endo', null, 'Hijiyama University', 22, 'Saḩab');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (9, 'Associate Professor', '(715) 8998319', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 1486.56, false, 'Shellysheldon', 'Downham', 'sdownham8@vistaprint.com', 'Dilate R Radial Art w 2 Intralum Dev, Perc Endo', null, 'Université de Toulouse', 20, 'Kacha');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (10, 'Nuclear Power Engineer', '(764) 6816163', 'Phasellus in felis.', 1960.01, true, 'Amber', 'Zamboniari', 'azamboniari9@goodreads.com', 'Repair Left Metacarpophalangeal Joint, Percutaneous Approach', null, 'University of Education Hradec Kralove', 19, 'Dimitrov');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (11, 'Software Test Engineer III', '(362) 3672804', 'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', 2759.47, true, 'Cahra', 'Rootham', 'croothama@washington.edu', 'Revision of Drain Dev in Low Tendon, Perc Endo Approach', null, 'Nangarhar University', 19, 'Ōme');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (12, 'Director of Sales', '(291) 3646569', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 2132.05, false, 'Aguistin', 'Joye', 'ajoyeb@dropbox.com', 'Revision of Int Fix in Cerv Jt, Perc Endo Approach', null, 'DeVry Institute of Technology, Chicago', 18, 'Batiano');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (13, 'Registered Nurse', '(931) 3212560', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.', 1182.09, true, 'Matteo', 'Pedgrift', 'mpedgriftc@yolasite.com', 'Excision of Left Elbow Joint, Perc Endo Approach', null, 'Universität Hohenheim', 23, 'Haozigang');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (14, 'Safety Technician I', '(844) 6335811', '', 1766.13, true, 'Bertrand', 'Scheffler', 'bschefflerd@shinystat.com', 'Supplement R Finger Phalanx w Nonaut Sub, Perc Endo', null, 'John Cabot University', 21, 'Māmūnīyeh');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (15, 'Engineer III', '(440) 1140203', 'Nulla suscipit ligula in lacus.', 1629.45, false, 'Sollie', 'Addess', 'saddesse@yellowpages.com', 'Removal of Synthetic Substitute from Up Jaw, Open Approach', null, 'Alkharj University', 20, 'Nanshi');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (16, 'Account Representative I', '(490) 9306593', 'Sed accumsan felis.', 2665.98, false, 'Allen', 'Winger', 'awingerf@vinaora.com', 'Revision of Infusion Device in Hepatobil Duct, Perc Approach', null, 'University of Tulsa', 21, 'Buenos Aires');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (17, 'Nuclear Power Engineer', '(399) 3375479', '', 2991.98, false, 'Brion', 'Braams', 'bbraamsg@parallels.com', 'Irrigation of Ear using Irrigating Substance, Endo, Diagn', null, 'Samara State Academy of Architecture and Civil Engineering', 22, 'Jalal-Abad');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (18, 'Operator', '(962) 4929162', 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 1555.71, true, 'Imelda', 'Morley', 'imorleyh@bigcartel.com', 'Occlusion of Face Artery, Open Approach', null, 'Université de Montpellier I', 19, 'Aguada de Pasajeros');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (19, 'Web Developer II', '(614) 5547689', 'Curabitur at ipsum ac tellus semper interdum.', 2543.79, true, 'Toinette', 'Radish', 'tradishi@marriott.com', 'Insertion of Monitor Dev into Pulm Trunk, Perc Endo Approach', null, 'Universidad Metropolitana de Honduras', 18, 'Puamata');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (20, 'General Manager', '(401) 5710063', 'Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.', 1581.01, false, 'Ly', 'Cabotto', 'lcabottoj@wsj.com', 'Removal of Synth Sub from R Acetabulum, Perc Approach', null, 'Université de Marne la Vallée', 18, 'Tubuhue');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (21, 'Mechanical Systems Engineer', '(519) 6294448', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 2801.2, false, 'Theressa', 'Eldon', 'teldonk@cloudflare.com', 'Revision of Nonaut Sub in C-thor Disc, Open Approach', null, 'Illinois State University', 21, 'Cishangang');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (22, 'Accountant II', '(342) 9270163', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 2771.65, false, 'Christiana', 'Reinmar', 'creinmarl@youtu.be', 'Fragmentation in Bladder, External Approach', null, 'Zuyd University', 19, 'Corinto');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (23, 'Nurse Practicioner', '(365) 8370372', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.', 1881.75, false, 'Kliment', 'Henryson', 'khenrysonm@squidoo.com', 'Revision of Autol Sub in L Elbow Jt, Perc Approach', null, 'Institute of Teachers Education, Tun Hussein Onn', 21, 'Tiantang');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (24, 'Mechanical Systems Engineer', '(453) 1480039', 'Etiam pretium iaculis justo.', 1141.15, true, 'Dur', 'Gilmartin', 'dgilmartinn@wired.com', 'Traction of Right Lower Leg', null, 'City University', 20, 'Banzhong');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (25, 'Executive Secretary', '(607) 3831451', '', 1145.07, false, 'Mychal', 'Beat', 'mbeato@qq.com', 'Supplement Esophagast Junct with Synth Sub, Open Approach', null, 'Islamic Azad University, Parand', 19, 'Perené');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (26, 'Marketing Manager', '(198) 3523657', 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 1685.46, true, 'Marshal', 'Dablin', 'mdablinp@indiatimes.com', 'Release Trachea, Endo', null, 'Technical University of Cluj-Napoca', 20, 'Mukun');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (27, 'Social Worker', '(547) 4365257', '', 1957.47, true, 'Ethelda', 'Corrigan', 'ecorriganq@icio.us', 'Alteration of Left Knee Region, Percutaneous Approach', null, 'Moldova State University of Medicine and Pharmacy "N. Testemitsanu"', 22, 'East Angus');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (28, 'Compensation Analyst', '(286) 4115804', '', 2135.08, false, 'Bo', 'Lambarton', 'blambartonr@mapy.cz', 'Release Left Temporomandibular Joint, External Approach', null, 'Universidad Andina Nestor Caceares Velasquez', 20, 'Taloqan');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (29, 'Nuclear Power Engineer', '(423) 2696522', 'Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 2991.2, false, 'Jeana', 'Brauninger', 'jbrauningers@chicagotribune.com', 'Division of Bilateral Kidneys, Percutaneous Approach', null, 'Huaqiao University Quanzhuo', 19, 'Suibara');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (30, 'GIS Technical Architect', '(613) 5598012', 'Fusce consequat. Nulla nisl.', 1205.4, false, 'Rickey', 'Tyer', 'rtyert@webs.com', 'Insert VAD Reservoir in L Low Arm Subcu/Fascia, Open', null, 'Virtual University of Pakistan', 18, 'Suai');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (31, 'Information Systems Manager', '(175) 8812709', '', 1618.96, true, 'Bob', 'Argrave', 'bargraveu@amazon.de', 'Dilate of R Peroneal Art with 3 Intralum Dev, Perc Approach', null, 'Kwara State University ', 21, 'Antony');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (32, 'VP Quality Control', '(386) 3567773', '', 1912.97, true, 'Correy', 'Chyuerton', 'cchyuertonv@infoseek.co.jp', 'Central Nervous System, Map', null, 'European University Portugal', 20, 'Antigonish');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (33, 'Senior Sales Associate', '(443) 3452253', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 1561.31, true, 'Odelle', 'Drysdall', 'odrysdallw@blogspot.com', 'Bypass L Com Iliac Art to Low Art, Perc Endo Approach', null, 'Universidad de Huánuco', 22, 'Urrao');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (34, 'Senior Cost Accountant', '(417) 9015012', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 2924.57, true, 'Domenic', 'Rispine', 'drispinex@ifeng.com', 'Repair Right Ovary, Percutaneous Approach', null, 'Universidad de Artes, Ciencias y Comunicación', 19, 'Stamboliyski');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (35, 'Tax Accountant', '(377) 3802905', 'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 1429.19, true, 'Winona', 'Moseley', 'wmoseleyy@shinystat.com', 'Restriction of Right Upper Lobe Bronchus, Open Approach', null, 'Evangel University', 22, 'Rungis');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (36, 'VP Quality Control', '(850) 5380979', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.', 1979.0, true, 'Aurore', 'Mc Gaughey', 'amcgaugheyz@squidoo.com', 'Excision of Right Lobe Liver, Perc Endo Approach', null, 'Christian Theological Academy in Warszaw', 23, 'Malway');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (37, 'Statistician IV', '(813) 9256363', '', 1118.15, true, 'Derward', 'Paine', 'dpaine10@163.com', 'Repair Left External Auditory Canal, Endo', null, 'Harvey Mudd College', 20, 'Bonavista');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (38, 'Engineer IV', '(599) 1998292', 'Morbi ut odio.', 1914.24, false, 'Ophelia', 'Hastings', 'ohastings11@google.co.jp', 'Insert Intspin Prcs Stabl Dev in Lum Jt, Perc Endo', null, 'Centro Universitário Plinio Leite', 19, 'Dzoraghbyur');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (39, 'Nurse', '(345) 3966980', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.', 2037.59, false, 'Michel', 'Ullett', 'mullett12@redcross.org', 'Drainage of Thoracic Nerve, Perc Endo Approach, Diagn', null, 'National Institute of Technology, Jamshedpur', 19, 'Voskresenskoye');
insert into users ( user_id, role, phone_number, coop_timeline, budget, housing_status, first_name, last_name, email, urgency, interests, university, age, preferred_location) values (40, 'Software Consultant', '(651) 1196044', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis.', 1481.94, false, 'Fabian', 'Eighteen', 'feighteen13@about.me', 'Reattachment of R Abd Bursa/Lig, Perc Endo Approach', null, 'Dr. B.R. Ambedkar Open University', 20, 'Vinica');

