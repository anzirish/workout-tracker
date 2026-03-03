import { errorResponse } from "../utils/apiResponse.js";

export const errorHandler = (err, req, res, next) => {
  return errorResponse(res, err.message, err.status);
};

export const invalidRoute = (req, res) => {
  return errorResponse(res, "Route not found", 404);
};
