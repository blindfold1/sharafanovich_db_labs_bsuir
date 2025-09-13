
INSERT INTO Users (email, password_hash, first_name, last_name, role_id)
VALUES ('newclient@studio.com', 'hash_newclient789', 'John', 'Doe', 3);

SELECT u.user_id, u.email, u.first_name, u.last_name, r.role_name
FROM Users u
JOIN Roles r ON u.role_id = r.role_id;

UPDATE Users
SET first_name = 'Bred'
WHERE email = 'newclient@studio.com';

DELETE FROM Users
WHERE email = 'newclient@studio.com';

SELECT b.booking_id, u.email, s.name AS studio_name, b.start_time, b.end_time, b.total_cost
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Studios s ON b.studio_id = s.studio_id
WHERE b.start_time >= '2025-09-14' AND b.start_time < '2025-09-15';

SELECT b.booking_id, e.name AS equipment_name, e.type
FROM Booking_Equipment be
JOIN Equipment e ON be.equipment_id = e.equipment_id
JOIN Bookings b ON be.booking_id = b.booking_id
WHERE b.booking_id = 1;

INSERT INTO Tracks (title, genre_id, duration, user_id, booking_id)
VALUES ('New track', 3, 200, 3, 1);

SELECT t.track_id, t.title, g.name AS genre, u.email
FROM Tracks t
JOIN Genres g ON t.genre_id = g.genre_id
JOIN Users u ON t.user_id = u.user_id;

UPDATE Equipment
SET is_available = FALSE
WHERE equipment_id = 1;

SELECT l.log_id, u.email, l.action, l.action_time
FROM Logs l
JOIN Users u ON l.user_id = u.user_id
WHERE l.action_time BETWEEN '2025-09-13 00:00:00' AND '2025-09-14 23:59:59';

SELECT SUM(p.amount) AS total_payments
FROM Payments p
WHERE p.payment_date >= '2025-09-01';

SELECT s.name, COUNT(b.booking_id) AS booking_count
FROM Studios s
LEFT JOIN Bookings b ON s.studio_id = b.studio_id
GROUP BY s.name;