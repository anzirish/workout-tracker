import { errorResponse } from "../utils/apiResponse.js";
import { verifyToken } from "../utils/jwtHelper.js";

export const protect = async (req, res, next) => {
  try {
    let token;

    // Check for token in Authorization header
    if (req.headers.authorization && req.headers.authorization.startsWith("Bearer")) {
      token = req.headers.authorization.split(" ")[1];
    }

    if (!token) {
      return errorResponse(res, "Not authorized, no token provided", 401);
    }

    // Verify token
    const decoded = verifyToken(token);

    // Attach user id to request
    req.user = { id: decoded.id };

    next();
  } catch (error) {
    if (error.name === "JsonWebTokenError") {
      return errorResponse(res, "Not authorized, invalid token", 401);
    }
    if (error.name === "TokenExpiredError") {
      return errorResponse(res, "Not authorized, token expired", 401);
    }
    return errorResponse(res, "Not authorized", 401);
  }
};
