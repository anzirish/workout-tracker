import { body, param } from "express-validator";

export const completeWorkoutValidator = [
  param("userId").isInt({ min: 1 }).withMessage("Invalid user ID"),

  param("workoutId").isInt({ min: 1 }).withMessage("Invalid workout ID"),

  body("completedAt")
    .notEmpty()
    .withMessage("Completed date is required")
    .isISO8601()
    .withMessage("Invalid date format. Use ISO 8601 format"),
];

export const userIdValidator = [
  param("userId").isInt({ min: 1 }).withMessage("Invalid user ID"),
];
