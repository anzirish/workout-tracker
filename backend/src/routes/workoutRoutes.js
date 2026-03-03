import express from "express"
import { getAllWorkouts, getWorkoutById } from "../controllers/workoutController.js"

export const workoutRouter = express.Router()

// GET /api/workouts
workoutRouter.get("/", getAllWorkouts)

// GET /api/workouts/:id
workoutRouter.get("/:id", getWorkoutById)