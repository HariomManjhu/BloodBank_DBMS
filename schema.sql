DROP TABLE IF EXISTS Blood_Request, Inventory, Donation, Donor, Hospital;

-- Hospital Table
CREATE TABLE Hospital (
    hospital_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL
);

-- Donor Table
CREATE TABLE Donor (
    donor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age BETWEEN 18 AND 65),
    gender ENUM('Male', 'Female', 'Other'),
    blood_group VARCHAR(3) NOT NULL,
    last_donation_date DATE,
    eligible BOOLEAN DEFAULT TRUE,
    INDEX(blood_group) -- speeds up search by blood group
);

-- Donation Table
CREATE TABLE Donation (
    donation_id INT PRIMARY KEY AUTO_INCREMENT,
    donor_id INT,
    hospital_id INT,
    donation_date DATE NOT NULL,
    volume_ml INT CHECK (volume_ml BETWEEN 200 AND 500),
    FOREIGN KEY (donor_id) REFERENCES Donor(donor_id),
    FOREIGN KEY (hospital_id) REFERENCES Hospital(hospital_id),
    UNIQUE(donor_id, donation_date) -- prevent duplicate donations same day
);

-- Inventory Table
CREATE TABLE Inventory (
    hospital_id INT,
    blood_group VARCHAR(3),
    available_units INT DEFAULT 0,
    PRIMARY KEY (hospital_id, blood_group),
    FOREIGN KEY (hospital_id) REFERENCES Hospital(hospital_id)
);

-- Blood Request Table
CREATE TABLE Blood_Request (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    hospital_id INT,
    blood_group VARCHAR(3),
    required_units INT,
    status ENUM('Pending', 'Fulfilled', 'Rejected') DEFAULT 'Pending',
    request_date DATE NOT NULL,
    FOREIGN KEY (hospital_id) REFERENCES Hospital(hospital_id)
);

-- Trigger: update eligibility flag after 60 days
DELIMITER //
CREATE TRIGGER update_eligibility
AFTER INSERT ON Donation
FOR EACH ROW
BEGIN
  UPDATE Donor
  SET last_donation_date = NEW.donation_date,
      eligible = FALSE
  WHERE donor_id = NEW.donor_id;
END;//
DELIMITER ;

-- Procedure: fulfill a request if enough units are present
DELIMITER //
CREATE PROCEDURE FulfillRequest(IN req_id INT)
BEGIN
  DECLARE bg VARCHAR(3);
  DECLARE hid INT;
  DECLARE needed INT;
  DECLARE current_stock INT;

  SELECT hospital_id, blood_group, required_units INTO hid, bg, needed
  FROM Blood_Request WHERE request_id = req_id;

  SELECT available_units INTO current_stock FROM Inventory
  WHERE hospital_id = hid AND blood_group = bg;

  START TRANSACTION;
  IF current_stock >= needed THEN
    UPDATE Inventory SET available_units = available_units - needed
    WHERE hospital_id = hid AND blood_group = bg;

    UPDATE Blood_Request SET status = 'Fulfilled' WHERE request_id = req_id;
  ELSE
    UPDATE Blood_Request SET status = 'Rejected' WHERE request_id = req_id;
  END IF;
  COMMIT;
END;//
DELIMITER ;

-- View: Status of blood availability
CREATE VIEW Blood_Inventory_View AS
SELECT h.name AS hospital_name, i.blood_group, i.available_units
FROM Hospital h
JOIN Inventory i ON h.hospital_id = i.hospital_id;
