# Workout Tracker - Tone Garage Assessment

## Overview

Full-stack workout tracking application with user authentication, workout management, and streak tracking features.

## Tech Stack

- Backend: Node.js/Express + MySQL
- Mobile: Flutter
- Database: MySQL

## Setup Instructions

### Backend Setup

1. Clone the repository
2. cd backend
3. npm install
4. Create MySQL database
5. Copy .env.example to .env and configure
6. npm run dev
7. API runs on http://localhost:3000

### Flutter App Setup

1. cd mobile
2. flutter pub get
3. Update API base URL in [lib/config/app_config.dart]
4. flutter run

### Database Setup

1. Create database: `CREATE DATABASE workout_tracker;`
2. Import schema: `mysql -u root -p workout_tracker < database/schema.sql`
3. Import seed data: `mysql -u root -p workout_tracker < database/seed.sql`

## Environment Variables

Create `backend/.env` file:

```
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=workout_tracker
PORT=3000

JWT_SECRET=your_super_secret_jwt_key
JWT_EXPIRES_IN=7d
```

## API Endpoints

### Authentication

**POST /api/auth/register**

```json
// Request
{
  "name": "Vipin Dev",
  "email": "vipin.dev@tonegarage.com",
  "password": "Apple@kh98"
}

// Response (201)
{
  "success": true,
  "data": {
    "user": {
      "id": 1,
      "name": "Vipin Dev",
      "email": "vipin.dev@tonegarage.com"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

**POST /api/auth/login**

```json
// Request
{
  "email": "vipin.dev@tonegarage.com",
  "password": "Apple@kh98"
}

// Response (200)
{
  "success": true,
  "data": {
    "user": {
      "id": 1,
      "name": "Vipin Dev",
      "email": "vipin.dev@tonegarage.com"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

**GET /api/auth/me** 

```json
// Headers
Authorization: Bearer <token>

// Response (200)
{
  "success": true,
  "data": {
    "id": 1,
    "name": "Vipin Dev",
    "email": "vipin.dev@tonegarage.com",
    "current_streak": 5,
    "last_workout_date": "2026-03-04",
    "created_at": "2026-03-01T10:00:00.000Z"
  }
}
```

### Workouts

**GET /api/workouts**

```json
// Response (200)
{
  "success": true,
  "data": [
    {
      "id": 1,
      "title": "Push Day",
      "description": "Upper body workout",
      "duration_minutes": 45,
      "difficulty": "Intermediate",
      "created_at": "2026-03-01T10:00:00.000Z"
    }
  ]
}
```

**GET /api/workouts/:id**

```json
// Response (200)
{
  "success": true,
  "data": {
    "id": 1,
    "title": "Push Day",
    "description": "Upper body workout",
    "duration_minutes": 45,
    "difficulty": "Intermediate",
    "created_at": "2026-03-01T10:00:00.000Z"
  }
}
```

### User Workouts

**GET /api/users/:userId/workout-history?page=1&limit=10**

```json
// Headers
Authorization: Bearer <token>

// Response (200)
{
  "success": true,
  "data": {
    "history": [
      {
        "user_workout_id": 1,
        "completed_at": "2026-03-04T14:30:00.000Z",
        "workout_id": 1,
        "title": "Push Day",
        "description": "Upper body workout",
        "duration_minutes": 45,
        "difficulty": "Intermediate"
      }
    ],
    "page": 1,
    "limit": 10,
    "total": 25
  }
}
```

**POST /api/users/:userId/workouts/:workoutId/complete**

```json
// Headers
Authorization: Bearer <token>

// Request
{
  "completedAt": "2026-03-04T14:30:00.000Z"
}

// Response (200)
{
  "success": true,
  "data": {
    "streak": 6,
    "completedAt": "2026-03-04T14:30:00.000Z"
  }
}
```

**GET /api/users/:userId/streak**

```json
// Headers
Authorization: Bearer <token>

// Response (200)
{
  "success": true,
  "data": {
    "streak": 6,
    "lastWorkoutDate": "2026-03-04"
  }
}
```

## Features Implemented

- [x] User authentication (register/login with JWT)
- [x] Workout list and details
- [x] Complete workout tracking
- [x] Workout history with pagination
- [x] Streak calculation and tracking
- [x] Input validation with express-validator
- [x] Protected routes with JWT middleware

## Project Structure

```
workout-tracker/
├── backend/
│   ├── src/
│   │   ├── config/         # Database configuration
│   │   ├── controllers/    # Route controllers
│   │   ├── middlewares/    # Auth & validation middlewares
│   │   ├── routes/         # API routes
│   │   ├── utils/          # Helpers & validators
│   │   └── server.js       # Entry point
│   ├── .env.example
│   └── package.json
├── mobile/
│   ├── lib/
│   │   ├── config/         # App configuration
│   │   ├── controllers/    # GetX controllers
│   │   ├── models/         # Data models
│   │   ├── screens/        # UI screens
│   │   ├── services/       # API service
│   │   └── main.dart       # Entry point
│   └── pubspec.yaml
└── database/
    ├── schema.sql          # Database schema
    └── seed.sql            # Sample data
```

## Challenges Faced

The main challenge was implementing the streak calculation logic correctly. The streak should increment only if the user completes a workout on consecutive days, reset to 1 if there's a gap, and remain the same if multiple workouts are completed on the same day.

The solution involved:
1. Converting dates to ISO string format (YYYY-MM-DD) for accurate comparison
2. Comparing the last workout date with today and yesterday
3. Handling edge cases like first-time users and same-day completions

## Future Improvements

- Migrate to Sequelize ORM for better data modeling and relationships
- Explore Flutter advanced features (animations, state management patterns)

## Time Spent

Approximately 44 hours