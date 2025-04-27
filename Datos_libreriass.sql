-- Insertar 10 datos completos
INSERT INTO editorial (nombre) VALUES 
('Editorial Anagrama'),
('Alfaguara'),
('Planeta'),
('Penguin Random House'),
('Tusquets Editores');

INSERT INTO autor (nombre, apellidos) VALUES 
('Gabriel', 'García Márquez'),
('Isabel', 'Allende'),
('Jorge Luis', 'Borges'),
('Julio', 'Cortázar'),
('Mario', 'Vargas Llosa'),
('Alana', 'S. Portero'),
('Javier', 'Castillo');

INSERT INTO libro (codigo_libro, titulo, isbn, codigo_editorial, paginas) VALUES 
('L001', 'Cien años de soledad', '9788420471839', 1, 432),
('L002', 'La casa de los espíritus', '9788401352898', 2, 368),
('L003', 'Ficciones', '9788426405159', 3, 218),
('L004', 'Rayuela', '9788437604572', 4, 635),
('L005', 'La ciudad y los perros', '9788432211928', 5, 382),
('L006', 'El amor en los tiempos del cólera', '9788497592451', 1, 490),
('L007', 'El Aleph', '9788499089515', 3, 210),
('L008', 'La mala costumbre', '9788432242120', 1, 256),
('L009', 'La grieta del silencio', '9786073844970', 2, 448),
('L010', 'Victoria', '9788408266608', 3, 560);

INSERT INTO autor_libro (codigo_autor, codigo_libro) VALUES 
(1, 'L001'),
(1, 'L006'), 
(2, 'L002'),
(3, 'L003'),
(3, 'L007'), 
(4, 'L004'), 
(5, 'L005'), 
(6, 'L008'),
(7, 'L009'), 
(8, 'L010'); 

INSERT INTO ejemplar (localizacion, codigo_libro) VALUES 
('Estante A1-01', 'L001'),
('Estante A1-02', 'L001'),
('Estante A2-01', 'L002'),
('Estante B1-01', 'L003'),
('Estante B2-01', 'L004'),
('Estante C1-01', 'L005'),
('Estante A1-03', 'L006'),
('Estante B1-02', 'L007'),
('Estante A2-02', 'L002'),
('Estante C1-02', 'L005'),
('Estante A1-04', 'L008'),
('Estante B2-02', 'L009'),
('Estante C2-01', 'L010');

INSERT INTO usuario (nombre, apellidos, telefono, direccion) VALUES 
('Ana', 'Martínez López', '612345678', 'Calle Mayor 15, Madrid'),
('Carlos', 'González Ruiz', '623456789', 'Avenida Libertad 23, Barcelona'),
('Elena', 'Sánchez Pérez', '634567890', 'Plaza España 7, Sevilla'),
('Miguel', 'Rodríguez Torres', '645678901', 'Calle Real 34, Valencia'),
('Laura', 'Fernández Gómez', '656789012', 'Calle Nueva 12, Bilbao');

INSERT INTO prestamo (codigo_usuario, id_ejemplar, fecha_prestamo, fecha_dev) VALUES 
(1, 1, '2025-03-01', '2025-03-15'),
(1, 4, '2025-03-10', '2025-03-24'),
(2, 2, '2025-03-05', '2025-03-19'),
(3, 3, '2025-03-07', '2025-03-21'),
(4, 5, '2025-03-12', '2025-03-26'),
(5, 6, '2025-03-15', '2025-03-29'),
(2, 7, '2025-03-20', '2025-04-03'),
(3, 8, '2025-03-22', '2025-04-05');

-- borar db
DROP DATABASE bibliotecass;

-- ver tablas
SELECT * FROM editorial;
SELECT * FROM autor;
SELECT * FROM libro;
SELECT * FROM autor_libro;
SELECT * FROM ejemplar;
SELECT * FROM usuario;
SELECT * FROM prestamo;

-- insertar medio millon de datos :p
USE bibliotecass;
DELIMITER $$
CREATE PROCEDURE medio_millon()
BEGIN
    DECLARE contador INT DEFAULT 1;

    WHILE contador <= 500000 DO
        -- Insertar autores
        INSERT INTO autor (nombre, apellidos)
        VALUES (CONCAT('Autor', contador), CONCAT('Apellido', contador));
        
        -- Insertar editoriales
        INSERT INTO editorial (nombre)
        VALUES (CONCAT('Editorial', contador));
        
        -- Insertar libros
        INSERT INTO libro (codigo_libro, titulo, isbn, codigo_editorial, paginas)
        VALUES (CONCAT('L', contador), CONCAT('Libro ', contador), CONCAT('ISBN', contador), (contador % 5) + 1, 100);

        -- Relacionar autores con libros
        INSERT INTO autor_libro (codigo_autor, codigo_libro)
        VALUES (contador, CONCAT('L', contador));

        -- Insertar ejemplares
        INSERT INTO ejemplar (localizacion, codigo_libro)
        VALUES (CONCAT('Estante A', contador, '-', contador), CONCAT('L', contador));

        -- Insertar usuarios
        INSERT INTO usuario (nombre, apellidos, telefono, direccion)
        VALUES (CONCAT('Usuario', contador), CONCAT('Apellido', contador), CONCAT('612345', contador), CONCAT('Calle', contador, ' 15'));

        -- Insertar préstamos
        INSERT INTO prestamo (codigo_usuario, id_ejemplar, fecha_prestamo, fecha_dev)
        VALUES (contador, contador, '2025-03-01', '2025-03-15');

        SET contador = contador + 1;
    END WHILE;

    COMMIT;
END $$
DELIMITER ;

CALL medio_millon();


