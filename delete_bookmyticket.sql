-- Connect to the BookMyTicket database
\c bookmyticket;

-- Drop tables in the correct order to handle dependencies
DROP TABLE IF EXISTS BookedSeats CASCADE;
DROP TABLE IF EXISTS Bookings CASCADE;
DROP TABLE IF EXISTS Seats CASCADE;
DROP TABLE IF EXISTS Schedules CASCADE;
DROP TABLE IF EXISTS Screens CASCADE;
DROP TABLE IF EXISTS Movies CASCADE;
DROP TABLE IF EXISTS Theatres CASCADE;
DROP TABLE IF EXISTS Cities CASCADE;
DROP TABLE IF EXISTS Users CASCADE;

-- Confirm all tables are dropped
\dt;

-- Drop the database if required (ensure you are connected to another database first)
\c postgres;
DROP DATABASE IF EXISTS bookmyticket;
