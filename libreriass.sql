
DROP DATABASE IF EXISTS bibliotecass;

CREATE DATABASE bibliotecass;

USE bibliotecass;

-- Tabla autor
DROP TABLE IF EXISTS autor;
CREATE TABLE autor (
    codigo_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL
);

-- Tabla editorial
DROP TABLE IF EXISTS editorial;
CREATE TABLE editorial (
    codigo_editorial INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla libro
DROP TABLE IF EXISTS libro;
CREATE TABLE libro (
    codigo_libro VARCHAR(20) PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    codigo_editorial INT NOT NULL,
    paginas INT NOT NULL,
    CHECK (paginas > 0),
    FOREIGN KEY (codigo_editorial) REFERENCES editorial(codigo_editorial) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla ejemplar
CREATE TABLE ejemplar (
    id_ejemplar INT AUTO_INCREMENT PRIMARY KEY,
    localizacion VARCHAR(100) NOT NULL,
    codigo_libro VARCHAR(20),
    FOREIGN KEY (codigo_libro) REFERENCES libro(codigo_libro) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla usuario
CREATE TABLE usuario (
    codigo_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(200) NOT NULL
);

-- Tabla de relación autor-libro (many-to-many)
DROP TABLE IF EXISTS autor_libro;
CREATE TABLE autor_libro (
    codigo_autor INT,
    codigo_libro VARCHAR(20),
    PRIMARY KEY (codigo_autor, codigo_libro),
    FOREIGN KEY (codigo_autor) REFERENCES autor(codigo_autor),
    FOREIGN KEY (codigo_libro) REFERENCES libro(codigo_libro)
);

-- Tabla de relación usuario-ejemplar (préstamos)
DROP TABLE IF EXISTS prestamo;
CREATE TABLE prestamo (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    codigo_usuario INT NOT NULL,
    id_ejemplar INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_dev DATE NOT NULL,
    UNIQUE (codigo_usuario, id_ejemplar, fecha_prestamo),
    FOREIGN KEY (codigo_usuario) REFERENCES usuario(codigo_usuario) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_ejemplar) REFERENCES ejemplar(id_ejemplar) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (fecha_prestamo < fecha_dev)
);
