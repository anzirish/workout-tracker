import { validationResult } from "express-validator";
import { errorResponse } from "../utils/apiResponse.js";

export const validate = (req, res, next) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    const errorMessages = errors.array().map((err) => err.msg);
    return errorResponse(res, errorMessages.join(", "), 400);
  }

  next();
};
