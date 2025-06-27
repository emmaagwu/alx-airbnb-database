# Airbnb Clone – Database Schema

## 🧱 Overview

This project defines the relational database schema for an Airbnb-style booking system. It includes entities for Users, Properties, Bookings, Payments, Reviews, and Messages.

---

## 📁 Files

- `schema.sql` – Contains all `CREATE TABLE` statements with constraints and indexes.
- Designed using principles of **normalization (3NF)** and follows the ERD documented earlier.

---

## 🧩 Entities & Purpose

| Table      | Description |
|------------|-------------|
| `User`     | Stores guest/host/admin information |
| `Property` | Listings created by hosts |
| `Booking`  | Guest reservations for properties |
| `Payment`  | Payment records linked to bookings |
| `Review`   | Guest reviews on properties |
| `Message`  | Direct messages between users |

---

## ✅ Features Implemented

- Primary and Foreign Keys
- ENUMs and Constraints (e.g., rating between 1-5, NOT NULL, etc.)
- Indexed columns for performance
- Cascading deletes on foreign keys
- Timestamp columns for tracking record creation

---

## ⚙️ Database Compatibility

- Compatible with **PostgreSQL** and **MySQL 8+**
- ENUMs may require modification in some versions of PostgreSQL

---

## 🚀 Getting Started

To create the schema:

```bash
psql -U your_username -d your_database -f schema.sql

or 

mysql -u your_username -p your_database < schema.sql
```

## 👨🏽‍💻 Author

**Agwu Emmanuel**  
Fullstack Engineer | ALX SE Program  
[LinkedIn](https://linkedin.com/in/emmaagwu) • [GitHub](https://github.com/emmaagwu)  
