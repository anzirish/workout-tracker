import express from "express";
import {
  getStreak,
  getWorkoutHistory,
  workoutComplete,
} from "../controllers/userController.js";
import { protect } from "../middlewares/authMiddleware.js";
import {
  completeWorkoutValidator,
  userIdValidator,
} from "../utils/userValidator.js";
import { validate } from "../middlewares/validationMiddleware.js";

export const userRouter = express.Router();

userRouter.use(protect);

// GET /api/users/:userId/workout-history
userRouter.get("/:userId/workout-history", userIdValidator, validate, getWorkoutHistory);

// POST /api/users/:userId/workouts/:workoutId/complete
userRouter.post(
  "/:userId/workouts/:workoutId/complete",
  completeWorkoutValidator,
  validate,
  workoutComplete
);

// GET /api/users/:userId/streak
userRouter.get("/:userId/streak", userIdValidator, validate, getStreak);