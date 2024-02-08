DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda; 

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

#Consultas tienda
#1
SELECT * FROM producto;
#2
SELECT nombre, precio FROM producto;
#3
SELECT nombre, precio, precio * 1.18 AS precio_usd FROM producto;
#4
SELECT nombre AS "nombre de producto", precio AS euros, precio * 1.18 AS "precio_usd" FROM producto;
#5
SELECT UPPER(nombre) AS nombre_mayuscula, precio FROM producto;
#6
SELECT LOWER(nombre) AS nombre_minuscula, precio FROM producto;
#7
SELECT nombre AS nombre_fabricante, UPPER(SUBSTRING(nombre, 1, 2)) AS dos_caracters FROM fabricante;
#8
SELECT nombre, ROUND(precio) AS precio_redondo FROM producto;
#9
SELECT nombre, truncate (precio, 0) AS precio_truncat FROM producto;
#10
SELECT nombre, truncate(precio, 0) AS precio_truncat FROM producto;
#11
SELECT DISTINCT codigo_fabricante FROM producto WHERE codigo_fabricante IS NOT NULL;
#12
SELECT nombre FROM fabricante ORDER BY nombre ASC;
#13
SELECT nombre FROM fabricante ORDER BY nombre DESC;
#14
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
#15
SELECT * FROM fabricante LIMIT 5;
#16
SELECT * FROM fabricante LIMIT 2 OFFSET 3; #limit 2 filas y a partir de la 4 fila seria el resultado
#17
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
#18
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
#19
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.codigo = 2;
#20
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo;
#21
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY nombre_fabricante ASC;
#22
SELECT p.codigo AS codigo_producto, p.nombre AS nombre_producto, p.codigo_fabricante, f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo;
#23
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio = (SELECT MIN(precio) FROM producto);
#24
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio = (SELECT MAX(precio) FROM producto);
#25
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Lenovo';
#26
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Crucial' AND p.precio > 200;
#27
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';
#28
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');
#29
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE RIGHT(f.nombre, 1) = 'e';
#30
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%w%';
#31
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;
#32
SELECT DISTINCT f.codigo, f.nombre
FROM fabricante f
JOIN producto p ON f.codigo = p.codigo_fabricante;
#33
SELECT f.codigo AS codigo_fabricante, f.nombre AS nombre_fabricante, p.codigo AS codigo_producto, p.nombre AS nombre_producto, p.precio
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
ORDER BY f.codigo, p.codigo;
#34
SELECT f.codigo AS codigo_fabricante, f.nombre AS nombre_fabricante
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.codigo IS NULL;
#35
SELECT *
FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');
#36
SELECT *
FROM producto
WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));
#37
SELECT nombre
FROM producto
WHERE precio = (
    SELECT MAX(precio)
    FROM producto
    WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo')
);
#38
select nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Hewlett-Packard'
ORDER BY producto.precio ASC
LIMIT 1;
#39
SELECT nombre
FROM producto
WHERE precio = (
    SELECT MIN(precio)
    FROM producto
    WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard')
);
#40
SELECT *
FROM producto
WHERE precio >= (
    SELECT MAX(precio)
    FROM producto
    WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo')
);
#41
SELECT *
FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus')
  AND precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus'));