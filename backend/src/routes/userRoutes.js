import express from "express"
import { getStreak, getWorkoutHistory, workoutComplete } from "../controllers/userController.js"

export const userRouter = express.Router()

// GET /api/users/:userId/workout-history
userRouter.get("/:userId/workout-history", getWorkoutHistory)

// POST /api/users/:userId/workouts/:workoutId/complete
userRouter.post("/:userId/workouts/:workoutId/complete", workoutComplete)

// GET /api/users/:userId/streak
userRouter.get("/:userId/streak", getStreak)