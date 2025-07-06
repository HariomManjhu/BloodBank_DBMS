#  Blood Bank & Donation Management System

A structured and normalized **MySQL-based DBMS project** for managing blood donors, hospitals, inventory, donations, and requests. Built entirely using SQL with proper schema design, triggers, procedures, and views.

---

##  Project Structure

- `schema.sql` – MySQL schema with tables, relationships, constraints, triggers, procedures, and views.
- `data.sql` – Sample data insertion for testing and demonstration.
- `queries.sql` – Useful queries to retrieve reports, insights, and statistics.
- `ER_Diagram.pdf` – Visual entity-relationship diagram for better understanding of database structure.

---

##  Database Features

- Fully normalized tables (3NF)
- Relational design with foreign keys
-  Triggers (e.g., update donor eligibility after donation)
-  Stored Procedure to fulfill blood requests atomically
-  View to check hospital-wise inventory

---

##  Sample Use Cases

- View eligible donors by blood group
- Track donation history of individuals
- Fulfill or reject blood requests based on stock
- Analyze top donors, pending requests, and donor stats

---

## 🔗 Entity Relationships

![ER Diagram](relational.pdf)

---
