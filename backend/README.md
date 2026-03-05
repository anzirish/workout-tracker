# Workout Tracker Backend

REST API for workout tracking application with JWT authentication.

## Tech Stack

- Node.js + Express.js
- MySQL (raw queries)
- JWT for authentication
- bcryptjs for password hashing
- express-validator for input validation

## Setup

### Prerequisites

- Node.js (v16+)
- MySQL (v8+)
- npm or yarn

### Installation

1. Install dependencies:
```bash
npm install
```

2. Configure environment variables:
```bash
cp .env.example .env
```

Edit `.env` with your database credentials:
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

3. Create database and import schema:
```bash
mysql -u root -p
CREATE DATABASE workout_tracker;
exit

mysql -u root -p workout_tracker < ../database/schema.sql
mysql -u root -p workout_tracker < ../database/seed.sql
```

4. Start the server:
```bash
npm run dev
```

Server will run on `http://localhost:3000`

## Project Structure

```
backend/
├── src/
│   ├── config/
│   │   └── db.js              # MySQL connection pool
│   ├── controllers/
│   │   ├── authController.js  # Auth endpoints
│   │   ├── userController.js  # User workout endpoints
│   │   └── workoutController.js # Workout CRUD
│   ├── middlewares/
│   │   ├── authMiddleware.js      # JWT verification
│   │   ├── errorHandler.js        # Global error handler
│   │   └── validationMiddleware.js # Validation error handler
│   ├── routes/
│   │   ├── authRoutes.js      # /api/auth routes
│   │   ├── userRoutes.js      # /api/users routes
│   │   └── workoutRoutes.js   # /api/workouts routes
│   ├── utils/
│   │   ├── apiResponse.js     # Response helpers
│   │   ├── jwtHelper.js       # JWT token functions
│   │   ├── authValidator.js   # Auth validation rules
│   │   └── userValidator.js   # User validation rules
│   └── server.js              # Entry point
├── .env.example
└── package.json
```

## API Endpoints

### Authentication (Public)
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `GET /api/auth/me` - Get current user (protected)

### Workouts (Public)
- `GET /api/workouts` - Get all workouts
- `GET /api/workouts/:id` - Get workout by ID

### User Workouts (Protected - Requires JWT)
- `GET /api/users/:userId/workout-history` - Get workout history with pagination
- `POST /api/users/:userId/workouts/:workoutId/complete` - Mark workout complete
- `GET /api/users/:userId/streak` - Get user streak

## Authentication

Protected routes require JWT token in Authorization header:
```
Authorization: Bearer <your_jwt_token>
```

Get token from `/api/auth/login` or `/api/auth/register` endpoints.

## Testing

Test with cURL:

```bash
# Register
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Vipin Dev","email":"vipin.dev@tonegarage@com","password":"password123"}'

# Login
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"Apple@jkj65"}'

# Get workouts
curl http://localhost:3000/api/workouts

# Complete workout (protected)
curl -X POST http://localhost:3000/api/users/1/workouts/1/complete \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"completedAt":"2026-03-04T14:30:00.000Z"}'
```

## Scripts

- `npm run dev` - Start development server with nodemon
- `npm test` - Run tests (not implemented)

## Dependencies

- express - Web framework
- mysql2 - MySQL client
- bcryptjs - Password hashing
- jsonwebtoken - JWT authentication
- express-validator - Input validation
- cors - CORS middleware
- dotenv - Environment variables
