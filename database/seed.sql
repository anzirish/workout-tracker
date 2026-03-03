USE workout_tracker;

-- User 1 for testing
INSERT INTO users (name, email, current_streak, last_workout_date) VALUES
  ('Test User', 'vipin.dev@tonegarage.com', 3, CURDATE());

-- Sample workouts
INSERT INTO workouts (title, description, duration_minutes, difficulty) VALUES
  ('Full Body Workout',   'Complete full body workout routine targeting all muscle groups',  45, 'Intermediate'),
  ('Morning Yoga',        'Gentle yoga session to improve flexibility and start the day right', 30, 'Beginner'),
  ('HIIT Cardio',         'High intensity cardio intervals to boost metabolism',              20, 'Advanced'),
  ('Core Strength',       'Focused ab and core workout for better stability',                 25, 'Intermediate'),
  ('Upper Body Blast',    'Chest, shoulders, and arms workout',                              40, 'Intermediate'),
  ('Leg Day',             'Squats, lunges and leg press for strong lower body',              50, 'Advanced'),
  ('Stretching Routine',  'Full body stretch to improve flexibility and recovery',           15, 'Beginner'),
  ('Push Day',            'Push exercises: bench press, overhead press, tricep dips',        45, 'Intermediate'),
  ('Pull Day',            'Pull exercises: rows, pull-ups, bicep curls',                     45, 'Intermediate'),
  ('Beginner Cardio',     'Light jogging and walking intervals for beginners',               30, 'Beginner');

-- Completed workouts for test user (user_id = 1)
INSERT INTO user_workouts (user_id, workout_id, completed_at) VALUES
  (1, 1, NOW()),                                         -- Today
  (1, 2, DATE_SUB(NOW(), INTERVAL 1 DAY)),               -- Yesterday
  (1, 3, DATE_SUB(NOW(), INTERVAL 2 DAY)),               -- 2 days ago
  (1, 4, DATE_SUB(NOW(), INTERVAL 4 DAY)),               -- 4 days ago (streak breaks)
  (1, 5, DATE_SUB(NOW(), INTERVAL 5 DAY));               -- 5 days ago