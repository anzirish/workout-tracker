import { pool } from "../config/db.js";
import { errorResponse, successReponse } from "../utils/apiResponse.js";

// check existance of a user
const findUser = async (userId) => {
  const [rows] = await pool.query("SELECT * FROM users WHERE id = ?", userId);
  return rows[0] || null;
};

// GET /api/users/:userId/workout-history
export const getWorkoutHistory = async (req, res, next) => {
  try {
    const { userId } = req.params;

    // pagination
    const page = parseInt(req.params.page) || 1;
    const limit = parseInt(req.params.limit) || 10;
    const offset = (page - 1) * limit;

    const user = await findUser(userId);

    if (!user) {
      return errorResponse(res, "User not found", 404);
    }

    const [history] = await pool.query(
      `SELECT uw.id AS user_workout_id, uw.completed_at, 
          w.id AS workout_id, w.title, w.description, w.duration_minutes, w.difficulty
          FROM user_workouts uw
          JOIN workouts w
          ON uw.workout_id = w.id
          WHERE uw.user_id = ?
          ORDER BY uw.completed_at DESC
          LIMIT ? OFFSET ?
          `,
      [userId, limit, offset],
    );

    const [[{ total }]] = await pool.query(
      `SELECT COUNT(*) AS total FROM user_workouts WHERE user_id = ?`,
      [userId],
    );

    return successReponse(res, { history, page, limit, total });
  } catch (error) {
    next(error);
  }
};

// POST /api/users/:userId/workouts/:workoutId/complete
export const workoutComplete = async (req, res, next) => {
  try {
    const { userId, workoutId } = req.params;
    const { completedAt } = req.body;

    const user = await findUser(userId);

    if (!user) {
      return errorResponse(res, "User not found", 404);
    }

    // check workout exists
    const [workoutRows] = await pool.query(
      `
      SELECT id, title FROM workouts WHERE id = ?
      `,
      [workoutId],
    );
    if (workoutRows.length === 0) {
      return errorResponse(res, "Workout not found", 404);
    }

    // parse completeAt date
    const completedDate = new Date(completedAt);
    if (isNaN(completedDate.getTime())) {
      return errorResponse(res, "Provided date is invalid", 400);
    }

    // insert new record in user_workouts table
    await pool.query(
      `
        INSERT INTO user_workouts (user_id, workout_id, completed_at)
        VALUES (?, ?, ?)
        `,
      [userId, workoutId, completedDate],
    );

    // calculate streak
    const todayString = new Date().toISOString().split("T")[0];

    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    const yesterdayString = yesterday.toISOString().split("T")[0];

    const lastWorkoutDate = user.last_workout_date
      ? new Date(user.last_workout_date).toISOString().split("T")[0]
      : null;

    let newStreak;

    if (lastWorkoutDate === todayString) {
      newStreak = user.current_streak;
    } else if (lastWorkoutDate === yesterdayString) {
      newStreak = user.current_streak + 1;
    } else {
      newStreak = 1;
    }

    // save streak
    await pool.query(
      `
      UPDATE users SET current_streak = ?,last_workout_date = ? WHERE id = ?
      `,
      [newStreak, todayString, userId],
    );

    return successReponse(res, {
      streak: newStreak,
      completedAt: completedDate.toISOString(),
    });
  } catch (error) {
    next(error);
  }
};

// GET /api/users/:userId/streak
export const getStreak = async (req, res, next) => {
  try {
    const { userId } = req.params;
    const user = await findUser(userId);

    if (!user) {
      return errorResponse(res, "User not found", 404);
    }

    return successReponse(res, {
      streak: user.current_streak,
      lastWorkoutDate: user.last_workout_date,
    });
  } catch (error) {
    next(error);
  }
};
