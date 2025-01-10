-- Insert cities
INSERT INTO Cities (CityID, Name)
VALUES
(411001, 'Pune'),
(400001, 'Mumbai');

-- Insert theatres
-- Pune Theatres
INSERT INTO Theatres (Name, CityID, Address, SeatingCapacity, Email, Mobile)
VALUES
('City Pride', 411001, 'Kothrud, Pune', 300, 'citypride.pune@theatre.com', '1234567890'),
('Inox', 411001, 'Camp, Pune', 300, 'inox.pune@theatre.com', '0987654321');

-- Mumbai Theatres
INSERT INTO Theatres (Name, CityID, Address, SeatingCapacity, Email, Mobile)
VALUES
('City Pride', 400001, 'Colaba, Mumbai', 300, 'citypride.mumbai@theatre.com', '2234567890'),
('Inox', 400001, 'Andheri, Mumbai', 300, 'inox.mumbai@theatre.com', '2987654321');

-- Insert screens for each theatre
INSERT INTO Screens (TheatreID, Name, SeatingCapacity, Description)
SELECT TheatreID, CONCAT('Screen ', s) AS Name, 100, 'Standard Screen'
FROM Theatres, generate_series(1, 3) AS s;

-- Insert seats for each screen
DO $$
DECLARE
    screen RECORD;
    row CHAR;
    seat_number INT;
BEGIN
    FOR screen IN SELECT ScreenID FROM Screens LOOP
        -- Iterate over rows using a SELECT query
        FOR row IN (SELECT UNNEST(ARRAY['A', 'B', 'C', 'D'])) LOOP
            FOR seat_number IN 1..25 LOOP
                INSERT INTO Seats (ScreenID, Row, Number, Category, Price, IsAvailable)
                VALUES (screen.ScreenID, row, seat_number, 'Standard', 200.00, TRUE);
            END LOOP;
        END LOOP;
    END LOOP;
END $$;
