import express from "express";
import cors from "cors";
import morgan from "morgan";
import { getConnection } from "../src/database/connection.js"; 
import productRoutes from "./routes/products.routes.js";

const app = express();

app.use(cors());
app.use(morgan("dev"));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());


getConnection()
  .then(pool => {
    console.log("Conectando correctamente a la base de datos");
  })
  .catch(error => {
    console.error("Error connecting to the database:", error);
  });

// Routes
app.use("/api/productos", productRoutes);

app.use("/", (req, res) => {
  res.json({
    message: "Bienvenido a la API de productos de sql server con nodejs",
  });
});

export default app;
