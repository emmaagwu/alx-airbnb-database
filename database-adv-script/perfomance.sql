-- Performance analysis for original (unoptimized) query

EXPLAIN
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,

    u.first_name,
    u.last_name,
    u.email,

    p.name AS property_name,
    p.location,

    pay.amount,
    pay.payment_method,
    pay.payment_date

FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON pay.booking_id = b.booking_id
WHERE b.status = 'confirmed' AND b.start_date >= '2024-01-01';
