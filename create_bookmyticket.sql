-- Create the database
CREATE DATABASE bookmyticket;

-- Switch to the new database
\c bookmyticket;

-- Table: Users
CREATE TABLE Users (
  UserID SERIAL PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Email VARCHAR(255) NOT NULL UNIQUE,
  Phone VARCHAR(15) NOT NULL,
  PasswordHash VARCHAR(255) NOT NULL,
  CreatedAt TIMESTAMP DEFAULT now(),
  UpdatedAt TIMESTAMP DEFAULT now()
);

-- Table: Cities
CREATE TABLE Cities (
  CityID SERIAL PRIMARY KEY,
  Name VARCHAR(100) NOT NULL UNIQUE
);

-- Table: Theatres
CREATE TABLE Theatres (
  TheatreID SERIAL PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  CityID INT NOT NULL REFERENCES Cities(CityID),
  Address TEXT NOT NULL,
  SeatingCapacity INT NOT NULL,
  Mobile VARCHAR(15) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  CreatedAt TIMESTAMP DEFAULT now(),
  UpdatedAt TIMESTAMP DEFAULT now()
);

-- Table: Screens
CREATE TABLE Screens (
  ScreenID SERIAL PRIMARY KEY,
  TheatreID INT NOT NULL REFERENCES Theatres(TheatreID),
  Name VARCHAR(50) NOT NULL,
  SeatingCapacity INT NOT NULL,
  Description TEXT,
  CreatedAt TIMESTAMP DEFAULT now(),
  UpdatedAt TIMESTAMP DEFAULT now()
);

-- Table: Movies
CREATE TABLE Movies (
  MovieID SERIAL PRIMARY KEY,
  Title VARCHAR(255) NOT NULL,
  Language VARCHAR(50) NOT NULL,
  Genre VARCHAR(50) NOT NULL,
  Duration INT NOT NULL,
  ReleaseDate DATE NOT NULL
);

-- Table: Schedules
CREATE TABLE Schedules (
  ScheduleID SERIAL PRIMARY KEY,
  TheatreID INT NOT NULL REFERENCES Theatres(TheatreID),
  ScreenID INT NOT NULL REFERENCES Screens(ScreenID),
  MovieID INT NOT NULL REFERENCES Movies(MovieID),
  ShowTime TIMESTAMP NOT NULL,
  CreatedAt TIMESTAMP DEFAULT now(),
  UpdatedAt TIMESTAMP DEFAULT now()
);

-- Table: Seats
CREATE TABLE Seats (
  SeatID SERIAL PRIMARY KEY,
  ScreenID INT NOT NULL REFERENCES Screens(ScreenID),
  Row VARCHAR(5) NOT NULL,
  Number INT NOT NULL,
  Category VARCHAR(50) NOT NULL,
  Price DECIMAL(10, 2) NOT NULL,
  IsAvailable BOOLEAN DEFAULT true,
  CreatedAt TIMESTAMP DEFAULT now(),
  UpdatedAt TIMESTAMP DEFAULT now()
);

-- Table: Bookings
CREATE TABLE Bookings (
  BookingID SERIAL PRIMARY KEY,
  ScheduleID INT NOT NULL REFERENCES Schedules(ScheduleID),
  UserID INT NOT NULL REFERENCES Users(UserID),
  TotalPrice DECIMAL(10, 2) NOT NULL,
  Status VARCHAR(20) DEFAULT 'Pending',
  CreatedAt TIMESTAMP DEFAULT now()
);

-- Table: BookedSeats
CREATE TABLE BookedSeats (
  BookingSeatID SERIAL PRIMARY KEY,
  BookingID INT NOT NULL REFERENCES Bookings(BookingID),
  SeatID INT NOT NULL REFERENCES Seats(SeatID),
  CreatedAt TIMESTAMP DEFAULT now(),
  Status VARCHAR(20) DEFAULT 'OPEN',
  LockedAt TIMESTAMP
);
