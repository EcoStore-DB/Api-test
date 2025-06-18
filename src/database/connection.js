import sql from "mssql";
import { DB_DATABASE, DB_PASSWORD, DB_SERVER, DB_USER } from "../config.js";

export const config = {
  user: 'sa',
  password: 'yourStrong(!)Password',
  server: 'localhost', // or the proper host name/IP
  database: 'webstore',
  options: {
    encrypt: false, // if required by your setup
    trustServerCertificate: true // if using a self-signed certificate
  }
};


export const getConnection = async () => {
  try {
    console.log("Conectando a la base de datos con las credenciales:", DB_USER, DB_SERVER, DB_DATABASE);  // Para depurar
    const pool = await sql.connect(config);
    console.log("Conectado a la base de datos");
    return pool;
  } catch (error) {
    console.error("Error al conectar a la base de datos:", error);
  }
};


export { sql };
