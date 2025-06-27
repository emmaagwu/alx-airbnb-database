# Database Normalization – Airbnb Clone Project

## ✅ Objective

To apply normalization principles to the Airbnb database design and ensure it meets the **Third Normal Form (3NF)**, removing redundancy, enforcing data integrity, and improving efficiency.

---

## 🧩 Step-by-Step Normalization

---

### 📗 First Normal Form (1NF)

✅ Achieved by:
- Ensuring that all attributes are **atomic** (no multivalued or repeating groups).
- All tables have **primary keys**.
- Example: Instead of storing multiple phone numbers in one column, we use just one phone number per row.

**Conclusion:** All tables have atomic fields and primary keys → ✅ 1NF achieved.

---

### 📘 Second Normal Form (2NF)

✅ Achieved by:
- Ensuring all **non-key attributes are fully functionally dependent** on the whole primary key.
- There are no partial dependencies (especially relevant in tables with **composite keys**, which we don’t use here).

**Conclusion:** All tables have simple (non-composite) primary keys, and no attributes depend on part of a composite key → ✅ 2NF achieved.

---

### 📙 Third Normal Form (3NF)

✅ Achieved by:
- Removing any **transitive dependencies** (i.e., when non-key columns depend on other non-key columns).
- Ensuring all non-key attributes depend **only** on the primary key.

**Review of Potential Issues:**
- In the `User` table, fields like `email`, `phone_number`, `role`, etc., depend **only** on `user_id`.
- In the `Property` table, attributes like `pricepernight`, `location`, etc., are direct properties of the `Property`.
- No derived or duplicated data is present.

**Conclusion:** No transitive dependencies exist → ✅ 3NF achieved.

---

## 🧼 Summary

| Normal Form | Description | Status |
|-------------|-------------|--------|
| 1NF | No repeating groups, atomic values | ✅ Passed |
| 2NF | Full functional dependency | ✅ Passed |
| 3NF | No transitive dependency | ✅ Passed |

---

## 📝 Notes

- The design is normalized up to 3NF to reduce redundancy and anomalies.
- Indexes and constraints (e.g., foreign keys, `NOT NULL`, `UNIQUE`) support **data integrity**.
- ENUMs are used to restrict values (e.g., status, role, payment method) — these could optionally be broken out into reference tables if higher flexibility is required.

---

## 📁 File Location

This file is located at:  
`alx-airbnb-database/normalization.md`
