-- Crear la base de datos
CREATE DATABASE SistemaReservasSalones_Normalizado;
GO

USE SistemaReservasSalones_Normalizado;
GO

-- Tabla de Tipos de Usuario
CREATE TABLE Tipos_Usuario (
    id_tipo_usuario INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255)
);

-- Tabla de Usuarios
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    fecha_registro DATETIME DEFAULT GETDATE()
);

-- Tabla de relaci�n Usuarios-Tipos (para manejar m�ltiples roles)
CREATE TABLE Usuarios_Tipos (
    id_usuario INT NOT NULL,
    id_tipo_usuario INT NOT NULL,
    PRIMARY KEY (id_usuario, id_tipo_usuario),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_tipo_usuario) REFERENCES Tipos_Usuario(id_tipo_usuario)
);

-- Tabla de Ubicaciones
CREATE TABLE Ubicaciones (
    id_ubicacion INT PRIMARY KEY IDENTITY(1,1),
    edificio VARCHAR(50) NOT NULL,
    piso VARCHAR(20) NOT NULL,
    ala VARCHAR(20) NOT NULL,
    descripcion VARCHAR(255)
);

-- Tabla de Salones
CREATE TABLE Salones (
    id_salon INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,
    id_ubicacion INT NOT NULL,
    precio_base_hora DECIMAL(10,2) NOT NULL,
    activo BIT DEFAULT 1,
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicaciones(id_ubicacion)
);

-- Tabla de Estados de Reserva
CREATE TABLE Estados_Reserva (
    id_estado_reserva INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255)
);

-- Tabla de Reservas
CREATE TABLE Reservas (
    id_reserva INT PRIMARY KEY IDENTITY(1,1),
    id_usuario INT NOT NULL,
    id_salon INT NOT NULL,
    id_estado_reserva INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE(),
    notas TEXT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_salon) REFERENCES Salones(id_salon),
    FOREIGN KEY (id_estado_reserva) REFERENCES Estados_Reserva(id_estado_reserva),
    CHECK (hora_fin > hora_inicio)
);

-- Tabla de Disponibilidad
CREATE TABLE Disponibilidad (
    id_disponibilidad INT PRIMARY KEY IDENTITY(1,1),
    id_salon INT NOT NULL,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    disponible BIT DEFAULT 1,
    motivo_no_disponible VARCHAR(255),
    FOREIGN KEY (id_salon) REFERENCES Salones(id_salon),
    CHECK (hora_fin > hora_inicio)
);

-- Tabla de M�todos de Pago
CREATE TABLE Metodos_Pago (
    id_metodo_pago INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255)
);

-- Tabla de Estados de Pago
CREATE TABLE Estados_Pago (
    id_estado_pago INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255)
);

-- Tabla de Pagos
CREATE TABLE Pagos (
    id_pago INT PRIMARY KEY IDENTITY(1,1),
    id_reserva INT NOT NULL,
    id_metodo_pago INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    id_estado_pago INT NOT NULL,
    fecha_pago DATETIME DEFAULT GETDATE(),
    transaccion_id VARCHAR(100),
    FOREIGN KEY (id_reserva) REFERENCES Reservas(id_reserva),
    FOREIGN KEY (id_metodo_pago) REFERENCES Metodos_Pago(id_metodo_pago),
    FOREIGN KEY (id_estado_pago) REFERENCES Estados_Pago(id_estado_pago)
);

-- Tabla de Auditor�a para Reservas
CREATE TABLE Auditoria_Reservas (
    id_auditoria INT PRIMARY KEY IDENTITY(1,1),
    id_reserva INT NOT NULL,
    campo_modificado VARCHAR(50) NOT NULL,
    valor_anterior VARCHAR(MAX),
    valor_nuevo VARCHAR(MAX),
    fecha_cambio DATETIME DEFAULT GETDATE(),
    usuario VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_reserva) REFERENCES Reservas(id_reserva)
);