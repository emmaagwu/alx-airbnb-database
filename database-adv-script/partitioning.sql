-- partitioning.sql
-- Implementing table partitioning on the Booking table based on start_date
-- Removes foreign keys due to MySQL partitioning limitation and adds triggers for integrity

-- Step 1: Create a backup of the existing Booking table
CREATE TABLE Booking_backup AS SELECT * FROM Booking;

-- Step 2: Drop existing foreign key constraints if they exist
-- (This handles the case where the table already exists with FKs)
SET FOREIGN_KEY_CHECKS = 0;

-- Step 3: Temporarily rename the existing table
RENAME TABLE Booking TO Booking_old;

-- Step 4: Create the new partitioned table without foreign keys
CREATE TABLE Booking (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,  -- Keep NOT NULL for data integrity
    user_id CHAR(36) NOT NULL,      -- Keep NOT NULL for data integrity
    start_date DATE NOT NULL,       -- NOT NULL is required for partitioning key
    end_date DATE,
    total_price DECIMAL(10, 2),
    status ENUM('pending', 'confirmed', 'canceled'),
    created_at DATETIME,
    
    -- Add indexes for performance (replacing foreign key indexes)
    INDEX idx_property_id (property_id),
    INDEX idx_user_id (user_id),
    INDEX idx_start_date (start_date),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) 
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);

-- Step 5: Create triggers to maintain referential integrity
DELIMITER //

-- Trigger to check property_id exists before insert
CREATE TRIGGER booking_property_check_insert
BEFORE INSERT ON Booking
FOR EACH ROW
BEGIN
    DECLARE property_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO property_count 
    FROM Property 
    WHERE property_id = NEW.property_id;
    
    IF property_count = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot insert booking: Referenced property_id does not exist';
    END IF;
END//

-- Trigger to check user_id exists before insert
CREATE TRIGGER booking_user_check_insert
BEFORE INSERT ON Booking
FOR EACH ROW
BEGIN
    DECLARE user_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO user_count 
    FROM User 
    WHERE user_id = NEW.user_id;
    
    IF user_count = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot insert booking: Referenced user_id does not exist';
    END IF;
END//

-- Trigger to check property_id exists before update
CREATE TRIGGER booking_property_check_update
BEFORE UPDATE ON Booking
FOR EACH ROW
BEGIN
    DECLARE property_count INT DEFAULT 0;
    
    -- Only check if property_id is being changed
    IF NEW.property_id != OLD.property_id THEN
        SELECT COUNT(*) INTO property_count 
        FROM Property 
        WHERE property_id = NEW.property_id;
        
        IF property_count = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Cannot update booking: Referenced property_id does not exist';
        END IF;
    END IF;
END//

-- Trigger to check user_id exists before update
CREATE TRIGGER booking_user_check_update
BEFORE UPDATE ON Booking
FOR EACH ROW
BEGIN
    DECLARE user_count INT DEFAULT 0;
    
    -- Only check if user_id is being changed
    IF NEW.user_id != OLD.user_id THEN
        SELECT COUNT(*) INTO user_count 
        FROM User 
        WHERE user_id = NEW.user_id;
        
        IF user_count = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Cannot update booking: Referenced user_id does not exist';
        END IF;
    END IF;
END//

DELIMITER ;

-- Step 6: Insert data from the old table into the new partitioned table
INSERT INTO Booking 
SELECT * FROM Booking_old;

-- Step 7: Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- Step 8: Verify the data transfer
-- Check row counts match
SELECT 
    (SELECT COUNT(*) FROM Booking) as new_table_count,
    (SELECT COUNT(*) FROM Booking_old) as old_table_count,
    CASE 
        WHEN (SELECT COUNT(*) FROM Booking) = (SELECT COUNT(*) FROM Booking_old) 
        THEN 'Data migration successful' 
        ELSE 'Data migration failed - counts do not match' 
    END as migration_status;

-- Step 9: Check partition distribution
SELECT 
    PARTITION_NAME,
    TABLE_ROWS,
    PARTITION_DESCRIPTION,
    PARTITION_METHOD
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'Booking' 
AND TABLE_SCHEMA = DATABASE()
AND PARTITION_NAME IS NOT NULL
ORDER BY PARTITION_ORDINAL_POSITION;

-- Step 10: Performance testing queries with EXPLAIN PARTITIONS
-- Query 1: Select bookings for a specific date range (should hit specific partitions)
EXPLAIN PARTITIONS
SELECT booking_id, property_id, user_id, start_date, end_date, total_price, status
FROM Booking 
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Query 2: Count bookings by year (should demonstrate partition pruning)
EXPLAIN PARTITIONS
SELECT YEAR(start_date) as booking_year, COUNT(*) as booking_count
FROM Booking 
WHERE start_date >= '2023-01-01'
GROUP BY YEAR(start_date)
ORDER BY booking_year;

-- Query 3: Recent bookings (should hit recent partitions only)
EXPLAIN PARTITIONS
SELECT booking_id, property_id, user_id, start_date, status
FROM Booking 
WHERE start_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
ORDER BY start_date DESC;

-- Query 4: Bookings by status and date range
EXPLAIN PARTITIONS
SELECT status, COUNT(*) as count, AVG(total_price) as avg_price
FROM Booking 
WHERE start_date BETWEEN '2024-06-01' AND '2024-08-31'
GROUP BY status;

-- Step 11: Integrity verification queries
-- Check for any orphaned records (should return 0 rows if triggers work)
SELECT 'Orphaned property_id records' as check_type, COUNT(*) as count
FROM Booking b 
LEFT JOIN Property p ON b.property_id = p.property_id 
WHERE p.property_id IS NULL

UNION ALL

SELECT 'Orphaned user_id records' as check_type, COUNT(*) as count
FROM Booking b 
LEFT JOIN User u ON b.user_id = u.user_id 
WHERE u.user_id IS NULL;

-- Step 12: Test the triggers (optional - remove comments to test)
/*
-- This should fail with trigger error message
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES ('test-1', 'non-existent-property', 'non-existent-user', '2024-07-01', '2024-07-05', 500.00, 'pending', NOW());
*/

-- Step 13: Cleanup (uncomment after verification)
-- DROP TABLE Booking_old;
-- DROP TABLE Booking_backup;

-- Step 14: Future partition management
-- Add new partitions as needed (run annually or as required)
-- ALTER TABLE Booking ADD PARTITION (PARTITION p2027 VALUES LESS THAN (2028));

-- Archive old partitions (careful - this deletes data!)
-- ALTER TABLE Booking DROP PARTITION p2022;

-- Performance monitoring query (run periodically)
SELECT 
    PARTITION_NAME,
    TABLE_ROWS,
    AVG_ROW_LENGTH,
    DATA_LENGTH,
    INDEX_LENGTH,
    (DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024 as size_mb
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'Booking' 
AND TABLE_SCHEMA = DATABASE()
AND PARTITION_NAME IS NOT NULL
ORDER BY PARTITION_ORDINAL_POSITION;