import dotenv from "dotenv";
dotenv.config();
import express from "express";
import cors from "cors";
import { workoutRouter } from "./routes/workoutRoutes.js";
import { userRouter } from "./routes/userRoutes.js";
import { authRouter } from "./routes/authRoutes.js";
import { errorHandler, invalidRoute } from "./middlewares/errorHandler.js";
import { connectDb } from "./config/db.js";

const app = express();

// middlewares
app.use(cors());
app.use(express.json());

// routes
app.get("/", (req, res) => {
  return res.status(200).json({ message: "Server is running" });
});
app.use("/api/auth", authRouter);
app.use("/api/workouts", workoutRouter);
app.use("/api/users", userRouter);

// error handling
app.use(invalidRoute);
app.use(errorHandler);

const startServer = async () => {
  await connectDb();
  const PORT = process.env.PORT;

  app.listen(PORT, () => {
    console.log("Server is running locally");
  });
};

startServer();
