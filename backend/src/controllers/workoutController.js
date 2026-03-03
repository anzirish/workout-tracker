import { pool } from "../config/db.js";
import { errorResponse, successReponse } from "../utils/apiResponse.js";

// GET /api/workouts
// get all available workouts
export const getAllWorkouts = async (req, res, next) => {
  try {
    const [workouts] = await pool.query(
      "SELECT id, title, description, duration_minutes, difficulty, created_at FROM workouts ORDER BY created_at DESC",
    );
    return successReponse(res, workouts);
  } catch (error) {
    next(error);
  }
};

// GET /api/workouts/:id 
// get workout by id
export const getWorkoutById = async (req, res, next) => {
  try {
    const { id } = req.params;
    const [rows] = await pool.query(
      "SELECT id, title, description, duration_minutes, difficulty, created_at FROM workouts WHERE id = ?",
      [id],
    );
    if (rows.length === 0) {
      return errorResponse(
        res,
        "Workout not found",
        404,
      );
    }
    return successReponse(res, rows[0]);
  } catch (error) {
    next(error);
  }
};
