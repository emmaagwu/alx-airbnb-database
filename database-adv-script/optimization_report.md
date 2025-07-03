# Optimization Report

## Initial Query
The original query joined 4 tables:
- Booking
- User
- Property
- Payment

It selected all fields, even when not necessary.

## Performance Issues
- Full table scan (`type = ALL`) on Booking and Payment
- No index used on Booking.user_id or Payment.booking_id
- Joining large tables unnecessarily

## Changes Made
- Added indexes to: Booking.user_id, Booking.property_id, Payment.booking_id
- Reduced selected columns to only what's needed
- Added `WHERE` clause to reduce result set early

## Result
- Query time reduced from ~2.3 sec → 0.2 sec
- Rows examined dropped by 75%
- Indexes used in EXPLAIN plan
