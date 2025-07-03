# 📈 Index Optimization Report – Airbnb Clone

This report explains how indexes were added to improve the performance of frequent SQL queries in the project.

---

## 🔍 1. Identifying Candidate Columns for Indexes

We analyzed earlier queries and identified the following columns frequently used in `WHERE`, `JOIN`, and `ORDER BY`:

| Table     | Column(s)                         | Reason for Indexing                     |
|-----------|-----------------------------------|-----------------------------------------|
| User      | user_id                           | Used in JOIN with Booking, Message      |
| Booking   | user_id, property_id, dates       | JOIN, filter by date, user activity     |
| Property  | host_id                           | JOIN with User                          |
| Review    | property_id                       | JOIN with Property                      |
| Message   | sender_id, recipient_id           | Used to filter user messages            |

---

## 🛠️ 2. Indexes Created

See `database_index.sql` for the complete index creation script.

---

## 📊 3. Performance Comparison Using `EXPLAIN`

### Query Before Index:

```sql
EXPLAIN
SELECT * FROM Booking
WHERE user_id = 'some-uuid';
