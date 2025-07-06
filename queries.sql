
-- 1.  Get all eligible donors by blood group
SELECT name, blood_group, age, gender
FROM Donor
WHERE eligible = TRUE
ORDER BY blood_group;

-- 2.  Show total available blood units by hospital
SELECT h.name AS hospital_name, i.blood_group, i.available_units
FROM Inventory i
JOIN Hospital h ON i.hospital_id = h.hospital_id
ORDER BY h.name;

-- 3.  List donors who donated in the last 90 days
SELECT name, donation_date
FROM Donor d
JOIN Donation dn ON d.donor_id = dn.donor_id
WHERE donation_date >= CURDATE() - INTERVAL 90 DAY;

-- 4.  Fulfilled and pending blood requests (status-based)
SELECT request_id, blood_group, required_units, status
FROM Blood_Request
WHERE status = 'Pending';

-- 5.  Top 3 donors who donated the most
SELECT d.name, COUNT(*) AS total_donations
FROM Donor d
JOIN Donation dn ON d.donor_id = dn.donor_id
GROUP BY d.donor_id
ORDER BY total_donations DESC
LIMIT 3;

-- 6.  Number of donors per blood group
SELECT blood_group, COUNT(*) AS donor_count
FROM Donor
GROUP BY blood_group;

-- 7.  Blood requests made by each hospital
SELECT h.name AS hospital, COUNT(*) AS total_requests
FROM Blood_Request br
JOIN Hospital h ON br.hospital_id = h.hospital_id
GROUP BY br.hospital_id;

-- 8.  Donors who are not eligible to donate
SELECT name, age, blood_group, last_donation_date
FROM Donor
WHERE eligible = FALSE;

-- 9.  View donation history of a specific donor (e.g., Riya Mehta)
SELECT d.name, dn.donation_date, dn.volume_ml, h.name AS hospital
FROM Donation dn
JOIN Donor d ON d.donor_id = dn.donor_id
JOIN Hospital h ON dn.hospital_id = h.hospital_id
WHERE d.name = 'Riya Mehta';

-- 10.  Blood groups that are out of stock at any hospital
SELECT h.name AS hospital, i.blood_group
FROM Inventory i
JOIN Hospital h ON i.hospital_id = h.hospital_id
WHERE i.available_units = 0;

-- 11.  Blood requests needing more than 2 units
SELECT request_id, blood_group, required_units, request_date
FROM Blood_Request
WHERE required_units > 2;

-- 12.  Check donor and how many unique hospitals they've donated to
SELECT d.name, COUNT(DISTINCT dn.hospital_id) AS hospitals_donated
FROM Donor d
JOIN Donation dn ON d.donor_id = dn.donor_id
GROUP BY d.donor_id;

-- 13.  Hospitals and dates they received donations
SELECT h.name AS hospital, dn.donation_date
FROM Donation dn
JOIN Hospital h ON dn.hospital_id = h.hospital_id
GROUP BY h.name, dn.donation_date
ORDER BY dn.donation_date DESC;

-- 14.  Requests for unavailable blood groups (not in inventory)
SELECT br.blood_group, h.name AS hospital
FROM Blood_Request br
LEFT JOIN Inventory i 
  ON br.hospital_id = i.hospital_id AND br.blood_group = i.blood_group
JOIN Hospital h ON br.hospital_id = h.hospital_id
WHERE i.blood_group IS NULL;

-- 15.  Average volume donated per donor
SELECT d.name, AVG(dn.volume_ml) AS avg_volume
FROM Donor d
JOIN Donation dn ON d.donor_id = dn.donor_id
GROUP BY d.donor_id;

-- 16.  List all donors and their donation count
SELECT d.name, COUNT(dn.donation_id) AS total_donations
FROM Donor d
LEFT JOIN Donation dn ON d.donor_id = dn.donor_id
GROUP BY d.donor_id;

