import { pool } from "../config/db.js";
import bcrypt from "bcryptjs";
import { errorResponse, successReponse } from "../utils/apiResponse.js";
import { generateToken } from "../utils/jwtHelper.js";

// POST /api/auth/register
export const register = async (req, res, next) => {
  try {
    const { name, email, password } = req.body;

    // Check if user already exists
    const [existingUsers] = await pool.query(
      "SELECT id FROM users WHERE email = ?",
      [email]
    );

    if (existingUsers.length > 0) {
      return errorResponse(res, "Email already registered", 409);
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Insert the new user
    const [result] = await pool.query(
      "INSERT INTO users (name, email, password) VALUES (?, ?, ?)",
      [name, email, hashedPassword]
    );

    const userId = result.insertId;

    // Generate token
    const token = generateToken(userId);

    return successReponse(
      res,
      {
        user: {
          id: userId,
          name,
          email,
        },
        token,
      },
      201
    );
  } catch (error) {
    next(error);
  }
};

// POST /api/auth/login
export const login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    // Find user by email
    const [users] = await pool.query(
      "SELECT id, name, email, password FROM users WHERE email = ?",
      [email]
    );

    if (users.length === 0) {
      return errorResponse(res, "Invalid email or password", 401);
    }

    const user = users[0];

    // Compare password
    const isPasswordValid = await bcrypt.compare(password, user.password);

    if (!isPasswordValid) {
      return errorResponse(res, "Invalid email or password", 401);
    }

    // Generate token
    const token = generateToken(user.id);

    return successReponse(res, {
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
      },
      token,
    });
  } catch (error) {
    next(error);
  }
};

// GET /api/auth/me
export const getMe = async (req, res, next) => {
  try {
    const userId = req.user.id; 

    const [users] = await pool.query(
      "SELECT id, name, email, current_streak, last_workout_date, created_at FROM users WHERE id = ?",
      [userId]
    );

    if (users.length === 0) {
      return errorResponse(res, "User not found", 404);
    }

    return successReponse(res, users[0]);
  } catch (error) {
    next(error);
  }
};
