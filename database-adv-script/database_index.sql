-- Indexes on the User table
CREATE INDEX idx_user_id ON User(user_id);

-- Indexes on the Booking table
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);

-- Indexes on the Property table
CREATE INDEX idx_property_host_id ON Property(host_id);

-- Indexes on the Review table
CREATE INDEX idx_review_property_id ON Review(property_id);

-- Indexes on the Message table
CREATE INDEX idx_message_sender ON Message(sender_id);
CREATE INDEX idx_message_recipient ON Message(recipient_id);
