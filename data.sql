-- 1. hospitals
INSERT INTO Hospital (name, location) VALUES
('Apollo Hospital', 'Hyderabad'),
('Medicover Hospital', 'Delhi'),
('Fortis Hospital', 'Mumbai');
-- 2. Donor
INSERT INTO Donor (name, age, gender, blood_group, last_donation_date, eligible) VALUES
('Hariom Manjhu', 18, 'Male', 'B+', NULL, TRUE),
('Shravan Bhangdiya', 20, 'Male', 'O+', '2024-05-10', TRUE),
('Bharath Kumar', 19, 'Male', 'A-', '2024-04-18', TRUE),
('Gaurav Agarwal', 20, 'Male', 'AB+', NULL, TRUE),
('Nikhil Salvi', 21, 'Male', 'B-', '2024-06-01', TRUE),
('Nikhil Mothukuri', 20, 'Male', 'O-', '2024-03-15', TRUE),
('Shivam Bhosle', 20, 'Male', 'A+', '2024-02-10', FALSE),
('Aryan Singh', 20, 'Male', 'O+', NULL, TRUE),
('Amit Kumar Sharma', 20, 'Male', 'B+', '2024-01-20', FALSE),
('Alok Chaudhary', 60, 'Male', 'AB-', NULL, FALSE), -- age 100 may violate your age check if added
('Bhanu Pratap', 19, 'Male', 'A+', '2024-06-05', TRUE);


-- 3. Donation
INSERT INTO Donation (donor_id, hospital_id, donation_date, volume_ml) VALUES
(1, 1, '2024-05-01', 450),
(2, 2, '2024-06-10', 470),
(3, 1, '2024-03-15', 430),
(5, 3, '2024-01-10', 420);

-- ----------------------------
-- 4. Inventory
-- ----------------------------
INSERT INTO Inventory (hospital_id, blood_group, available_units) VALUES
(1, 'O+', 5),
(1, 'B+', 2),
(2, 'A-', 3),
(2, 'AB+', 0),
(3, 'O-', 1);

-- ----------------------------
-- 5. Blood_Request
-- ----------------------------
INSERT INTO Blood_Request (hospital_id, blood_group, required_units, request_date) VALUES
(1, 'O+', 2, '2024-07-01'),
(2, 'AB+', 1, '2024-07-02'),
(3, 'O-', 3, '2024-07-03');
