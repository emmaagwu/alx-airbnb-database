
---

## 🔧 0. Write Complex Queries with Joins

**Objective:** Practice and master various types of SQL joins to combine and extract meaningful information from multiple tables.

**File:** `joins_queries.sql`

**Tasks:**
- `INNER JOIN` → Get all bookings along with the users who made them.
- `LEFT JOIN` → Retrieve all properties and any reviews they have (if any).
- `FULL OUTER JOIN` → Get a comprehensive list of users and bookings, even where no association exists.

---

## 🧩 1. Practice Subqueries

**Objective:** Learn and apply both correlated and non-correlated subqueries to extract complex insights.

**File:** `subqueries.sql`

**Tasks:**
- Non-correlated subquery → List all properties with an average rating > 4.0.
- Correlated subquery → Find users who have made more than 3 bookings.

---

## 📈 2. Apply Aggregations and Window Functions

**Objective:** Use aggregate functions and window functions for data analysis and ranking.

**File:** `aggregations_and_window_functions.sql`

**Tasks:**
- Use `COUNT` and `GROUP BY` to get total bookings per user.
- Use `RANK()` or `ROW_NUMBER()` to rank properties by booking count.

---

## ⚙️ 3. Implement Indexes for Optimization

**Objective:** Improve query performance by identifying and creating appropriate indexes.

**Files:**
- Index creation queries → `database_index.sql`
- Report → `index_performance.md`

**Tasks:**
- Create indexes on frequently used columns (in `WHERE`, `JOIN`, or `ORDER BY`).
- Use `EXPLAIN` or `ANALYZE` to measure performance before and after indexing.

---

## 🚀 4. Optimize Complex Queries

**Objective:** Refactor and tune slow queries for faster execution and better efficiency.

**Files:**
- Initial query → `perfomance.sql`
- Optimization report → `optimization_report.md`

**Tasks:**
- Write a full query that joins Users, Bookings, Properties, and Payments.
- Analyze its performance using `EXPLAIN`.
- Refactor to reduce overhead and improve execution time.

---

## 📂 5. Partitioning Large Tables

**Objective:** Boost query speed on large datasets by implementing table partitioning.

**Files:**
- Partitioning SQL → `partitioning.sql`
- Performance analysis → `partition_performance.md`

**Tasks:**
- Partition the `Booking` table based on `start_date`.
- Compare performance of date-range queries before and after partitioning.

---

## 🛠️ 6. Monitor and Refine Database Performance

**Objective:** Use performance monitoring tools to evaluate and refine query execution strategies.

**File:** `performance_monitoring.md`

**Tasks:**
- Monitor frequently used queries using `SHOW PROFILE`, `EXPLAIN`, or `ANALYZE`.
- Identify bottlenecks.
- Recommend or implement changes such as schema redesign or index adjustments.

---

## ✅ What You Will Learn

By working through these scripts, you will gain hands-on experience in:

- Writing efficient multi-table SQL queries.
- Structuring complex subqueries and analytical queries.
- Applying aggregation and ranking techniques.
- Creating indexes for performance.
- Refactoring real-world SQL queries for speed and clarity.
- Partitioning strategies for big data.
- Monitoring and debugging SQL performance issues.

---

## 💡 Getting Started

1. Clone the project repository:
   ```bash
   git clone https://github.com/YOUR-USERNAME/alx-airbnb-database.git
   cd alx-airbnb-database/database-adv-script
