# Airbnb Clone – Database Seed Data

## 🌱 Overview

This directory contains SQL seed data for testing and demonstrating the Airbnb relational database schema.

The `seed.sql` file populates all major entities with realistic data that reflects typical usage of the platform, including hosts, guests, bookings, payments, and reviews.

---

## 📄 Files

- `seed.sql` – SQL `INSERT INTO` statements for:
  - Users
  - Properties
  - Bookings
  - Payments
  - Reviews
  - Messages

---

## 🔗 Relationships Demonstrated

- A host user owns multiple properties
- Guests book those properties
- Each booking has an associated payment
- Guests leave reviews for properties
- Users exchange messages (host ↔ guest)

---

## 🚀 How to Use

Run this script after your schema has been created:

```bash
psql -U your_user -d your_database -f seed.sql
