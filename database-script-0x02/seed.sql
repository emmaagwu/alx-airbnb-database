-- Clear existing data for clean seeding
-- (Optional - uncomment only in dev)
-- DELETE FROM Message;
-- DELETE FROM Review;
-- DELETE FROM Payment;
-- DELETE FROM Booking;
-- DELETE FROM Property;
-- DELETE FROM User;

-- 1️⃣ USERS (15 total: 5 hosts, 10 guests)
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
  -- Hosts
  ('u-001', 'Emmanuel', 'Agwu', 'emmanuel@example.com', 'passhash1', '08012345678', 'host'),
  ('u-002', 'Jane', 'Doe', 'jane@example.com', 'passhash2', '08111111111', 'host'),
  ('u-003', 'Victor', 'Ola', 'victor@example.com', 'passhash3', '07000000000', 'host'),
  ('u-004', 'Linda', 'Brown', 'linda@example.com', 'passhash4', '08122223333', 'host'),
  ('u-005', 'Tunde', 'Okoro', 'tunde@example.com', 'passhash5', '08087654321', 'host'),

  -- Guests
  ('u-006', 'Grace', 'Jones', 'grace@example.com', 'passhash6', '08123456789', 'guest'),
  ('u-007', 'Michael', 'Smith', 'mike@example.com', 'passhash7', NULL, 'guest'),
  ('u-008', 'Femi', 'Adebayo', 'femi@example.com', 'passhash8', '08111112222', 'guest'),
  ('u-009', 'Cynthia', 'Black', 'cynthia@example.com', 'passhash9', NULL, 'guest'),
  ('u-010', 'Aisha', 'Ahmed', 'aisha@example.com', 'passhash10', '08100000000', 'guest'),
  ('u-011', 'Paul', 'Nwachukwu', 'paul@example.com', 'passhash11', '07012312312', 'guest'),
  ('u-012', 'Joy', 'Kalu', 'joy@example.com', 'passhash12', NULL, 'guest'),
  ('u-013', 'Obi', 'John', 'obi@example.com', 'passhash13', '07099887766', 'guest'),
  ('u-014', 'Evelyn', 'Ngige', 'evelyn@example.com', 'passhash14', NULL, 'guest'),
  ('u-015', 'Samuel', 'Adams', 'samuel@example.com', 'passhash15', '08133334444', 'guest');

-- 2️⃣ PROPERTIES (7 total)
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES
  ('p-001', 'u-001', 'Cozy Apartment', 'Lovely 2-bedroom in Lagos.', 'Lagos', 150.00),
  ('p-002', 'u-002', 'Lekki Beach House', 'Ocean view in Lekki.', 'Lekki', 300.00),
  ('p-003', 'u-003', 'City View Loft', 'Stylish apartment in Ikeja.', 'Ikeja', 200.00),
  ('p-004', 'u-004', 'Abuja Bungalow', 'Peaceful home in Abuja.', 'Abuja', 180.00),
  ('p-005', 'u-005', 'Studio Flat', 'Affordable studio in Yaba.', 'Yaba', 100.00),
  ('p-006', 'u-001', 'Victoria Island Villa', 'Luxury stay in VI.', 'Victoria Island', 400.00),
  ('p-007', 'u-003', 'Island Retreat', 'Perfect for vacations.', 'Banana Island', 600.00);

-- 3️⃣ BOOKINGS (10 total)
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  ('b-001', 'p-001', 'u-006', '2025-07-01', '2025-07-05', 600.00, 'confirmed'),
  ('b-002', 'p-002', 'u-007', '2025-07-10', '2025-07-14', 1200.00, 'pending'),
  ('b-003', 'p-003', 'u-008', '2025-08-01', '2025-08-06', 1000.00, 'confirmed'),
  ('b-004', 'p-004', 'u-009', '2025-08-15', '2025-08-18', 540.00, 'canceled'),
  ('b-005', 'p-005', 'u-010', '2025-09-01', '2025-09-05', 400.00, 'confirmed'),
  ('b-006', 'p-006', 'u-011', '2025-09-10', '2025-09-15', 2000.00, 'confirmed'),
  ('b-007', 'p-007', 'u-012', '2025-10-01', '2025-10-03', 1200.00, 'pending'),
  ('b-008', 'p-001', 'u-013', '2025-10-15', '2025-10-17', 300.00, 'confirmed'),
  ('b-009', 'p-002', 'u-014', '2025-11-01', '2025-11-04', 900.00, 'confirmed'),
  ('b-010', 'p-004', 'u-015', '2025-12-01', '2025-12-06', 1080.00, 'pending');

-- 4️⃣ PAYMENTS (7 total — not every booking paid yet)
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
  ('pay-001', 'b-001', 600.00, 'credit_card'),
  ('pay-002', 'b-003', 1000.00, 'paypal'),
  ('pay-003', 'b-005', 400.00, 'stripe'),
  ('pay-004', 'b-006', 2000.00, 'paypal'),
  ('pay-005', 'b-008', 300.00, 'credit_card'),
  ('pay-006', 'b-009', 900.00, 'stripe'),
  ('pay-007', 'b-010', 1080.00, 'paypal');

-- 5️⃣ REVIEWS (6 total)
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
  ('r-001', 'p-001', 'u-006', 5, 'Amazing stay. Super clean and quiet.'),
  ('r-002', 'p-002', 'u-007', 4, 'Beautiful view, but noisy neighbors.'),
  ('r-003', 'p-003', 'u-008', 5, 'Excellent location and host was great!'),
  ('r-004', 'p-005', 'u-010', 3, 'Okay for the price. Small but functional.'),
  ('r-005', 'p-006', 'u-011', 5, 'Luxury experience. Worth every naira.'),
  ('r-006', 'p-007', 'u-012', 4, 'Perfect vacation spot. Just the WiFi was slow.');

-- 6️⃣ MESSAGES (6 total)
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
  ('m-001', 'u-006', 'u-001', 'Hi, is the apartment still available on July 1st?'),
  ('m-002', 'u-001', 'u-006', 'Yes! Feel free to book it now.'),
  ('m-003', 'u-007', 'u-002', 'Can I check in early?'),
  ('m-004', 'u-002', 'u-007', 'Sure, we allow early check-ins before noon.'),
  ('m-005', 'u-008', 'u-003', 'Is there WiFi and AC in the property?'),
  ('m-006', 'u-003', 'u-008', 'Yes, both are available and included.');
