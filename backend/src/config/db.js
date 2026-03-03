import mysql from "mysql2/promise";

let pool;

// connect mysql database
export const connectDb = async () => {
  try {
    pool = mysql.createPool({
      host: process.env.DB_HOST,
      port: process.env.DB_PORT,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
    });
    
    await pool.getConnection();
    console.log("MySql connected");
  } catch (error) {
    console.log("Mysql error", error);
    process.exit(1);
  }
};

export { pool };
