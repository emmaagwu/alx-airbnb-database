# Database Performance Monitoring Report

## Objective
To monitor real query performance and improve the database schema by reducing query time and increasing efficiency.

---

## 🔍 Monitored Queries and Observations

### Query 1: Fetch bookings by user
```sql
SELECT * FROM Booking WHERE user_id = 'some-id';
