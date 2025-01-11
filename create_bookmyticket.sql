-- Create the database
CREATE DATABASE bookmyticket;

-- Switch to the new database
\c bookmyticket;

-- Table: users
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  phone VARCHAR(15) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

-- Table: cities
CREATE TABLE cities (
  city_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
);

-- Table: theatres
CREATE TABLE theatres (
  theatre_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  city_id INT NOT NULL REFERENCES cities(city_id),
  address TEXT NOT NULL,
  seating_capacity INT NOT NULL,
  mobile VARCHAR(15) NOT NULL,
  email VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

-- Table: screens
CREATE TABLE screens (
  screen_id SERIAL PRIMARY KEY,
  theatre_id INT NOT NULL REFERENCES theatres(theatre_id),
  name VARCHAR(50) NOT NULL,
  seating_capacity INT NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

-- Table: movies
CREATE TABLE movies (
  movie_id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  language VARCHAR(50) NOT NULL,
  genre VARCHAR(50) NOT NULL,
  duration INT NOT NULL,
  release_date DATE NOT NULL
);

-- Table: schedules
CREATE TABLE schedules (
  schedule_id SERIAL PRIMARY KEY,
  theatre_id INT NOT NULL REFERENCES theatres(theatre_id),
  screen_id INT NOT NULL REFERENCES screens(screen_id),
  movie_id INT NOT NULL REFERENCES movies(movie_id),
  show_time TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

-- Table: seats
CREATE TABLE seats (
  seat_id SERIAL PRIMARY KEY,
  screen_id INT NOT NULL REFERENCES screens(screen_id),
  row VARCHAR(5) NOT NULL,
  number INT NOT NULL,
  category VARCHAR(50) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  is_available BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);

-- Table: bookings
CREATE TABLE bookings (
  booking_id SERIAL PRIMARY KEY,
  schedule_id INT NOT NULL REFERENCES schedules(schedule_id),
  user_id INT NOT NULL REFERENCES users(user_id),
  total_price DECIMAL(10, 2) NOT NULL,
  status VARCHAR(20) DEFAULT 'Pending',
  created_at TIMESTAMP DEFAULT now()
);

-- Table: booked_seats
CREATE TABLE booked_seats (
  booked_seat_id SERIAL PRIMARY KEY,
  booking_id INT NOT NULL REFERENCES bookings(booking_id),
  seat_id INT NOT NULL REFERENCES seats(seat_id),
  created_at TIMESTAMP DEFAULT now(),
  status VARCHAR(20) DEFAULT 'OPEN',
  locked_at TIMESTAMP
);

-- Table: transactions
CREATE TABLE transactions (
  transaction_id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(user_id),
  booking_id BIGINT NOT NULL REFERENCES bookings(booking_id),
  payment_method VARCHAR(50) NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  status VARCHAR(20) DEFAULT 'PENDING',
  transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: refunds
CREATE TABLE refunds (
  refund_id BIGSERIAL PRIMARY KEY,
  transaction_id BIGINT NOT NULL REFERENCES transactions(transaction_id),
  refund_amount DECIMAL(10, 2) NOT NULL,
  refund_reason VARCHAR(255),
  status VARCHAR(20) DEFAULT 'PENDING',
  refund_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: payment_methods
CREATE TABLE payment_methods (
  method_id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(user_id),
  method_type VARCHAR(50) NOT NULL,
  details JSON NOT NULL,
  is_default BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
