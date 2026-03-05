import { Router } from "express";
import { register, login, getMe } from "../controllers/authController.js";
import { protect } from "../middlewares/authMiddleware.js";
import { registerValidator, loginValidator } from "../utils/authValidator.js";
import { validate } from "../middlewares/validationMiddleware.js";

const authRouter = Router();

authRouter.post("/register", registerValidator, validate, register);
authRouter.post("/login", loginValidator, validate, login);
authRouter.get("/me", protect, getMe);

export { authRouter };
