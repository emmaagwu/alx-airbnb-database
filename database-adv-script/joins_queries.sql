-- INNER JOIN: Get all bookings with the users who made them
SELECT 
    Booking.booking_id,
    Booking.property_id,
    Booking.start_date,
    Booking.end_date,
    Booking.total_price,
    Booking.status,
    User.user_id,
    User.first_name,
    User.last_name,
    User.email
FROM Booking
INNER JOIN User ON Booking.user_id = User.user_id;


-- LEFT JOIN: Get all properties with their reviews (even if no review)
SELECT 
    Property.property_id,
    Property.name,
    Property.location,
    Property.pricepernight,
    Review.review_id,
    Review.rating,
    Review.comment,
    Review.created_at
FROM Property
LEFT JOIN Review ON Property.property_id = Review.property_id;


-- FULL OUTER JOIN: Users and Bookings (even if no match)
-- MySQL does not support FULL OUTER JOIN directly,
-- so we simulate it using UNION of LEFT and RIGHT JOINs

-- LEFT JOIN part: all users and their bookings (if any)
SELECT 
    User.user_id,
    User.first_name,
    User.last_name,
    Booking.booking_id,
    Booking.property_id,
    Booking.start_date,
    Booking.status
FROM User
LEFT JOIN Booking ON User.user_id = Booking.user_id

UNION

-- RIGHT JOIN part: all bookings and their users (if any)
SELECT 
    User.user_id,
    User.first_name,
    User.last_name,
    Booking.booking_id,
    Booking.property_id,
    Booking.start_date,
    Booking.status
FROM User
RIGHT JOIN Booking ON User.user_id = Booking.user_id;
