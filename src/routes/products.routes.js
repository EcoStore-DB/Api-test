import { Router } from "express";

const router = Router();

// Obtener todos los productos
router.get("/", (req, res) => {
  res.json({ message: "Obteniendo productos" });
});

// Obtener un solo producto por ID
router.get("/:id", (req, res) => {
  res.json({ message: `Obteniendo producto con ID` });
});

// Crear un nuevo producto
router.post("/", (req, res) => {
  res.json({ message: "Creando un producto" });
});

// Actualizar un producto por ID
router.put("/:id", (req, res) => {
  res.json({ message: `Actualizando producto con ID` });
});

// Eliminar un producto por ID
router.delete("/:id", (req, res) => {
  res.json({ message: `Eliminando producto con ID ` });
});

export default router;
