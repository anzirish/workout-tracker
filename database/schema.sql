CREATE DATABASE IF NOT EXISTS workout_tracker;
USE workout_tracker;

-- Users table
CREATE TABLE IF NOT EXISTS users (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  name       VARCHAR(255) NOT NULL,
  email      VARCHAR(255) UNIQUE NOT NULL,
  current_streak    INT DEFAULT 0,
last_workout_date DATE DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Workouts table
CREATE TABLE IF NOT EXISTS workouts (
  id               INT PRIMARY KEY AUTO_INCREMENT,
  title            VARCHAR(255) NOT NULL,
  description      TEXT,
  duration_minutes INT NOT NULL CHECK (duration_minutes > 0),
  difficulty       ENUM('Beginner', 'Intermediate', 'Advanced') NOT NULL,
  created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User_workouts table
CREATE TABLE IF NOT EXISTS user_workouts (
  id           INT PRIMARY KEY AUTO_INCREMENT,
  user_id      INT NOT NULL,
  workout_id   INT NOT NULL,
  completed_at TIMESTAMP NOT NULL,
  FOREIGN KEY (user_id)    REFERENCES users(id)    ON DELETE CASCADE,
  FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE
);

-- Indexe for performance
CREATE INDEX idx_user_workouts_user_id      ON user_workouts(user_id);