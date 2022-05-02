-- CLASE 17A VISTAS --
/*1. A. Crear una vista denominada “vista_mostrar_pais” que devuelva un reporte
de los países.*/

CREATE VIEW vista_mostrar_pais AS
SELECT * FROM country;

-- b) Invocar la vista creada.
SELECT * FROM vista_mostrar_pais;

/* 2. a) Crear una vista que devuelva un resumen con el apellido y nombre (en una sola columna denominada “artista”) de los artistas y la cantidad de filmaciones que tienen. Traer solo aquellos que tengan más de 25
filmaciones y ordenarlos por apellido.*/

CREATE VIEW vista_artista AS
SELECT concat(first_name,' ', last_name) AS artista, count(*) AS filmaciones FROM film_actor
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY artista
HAVING filmaciones > 25
ORDER BY last_name;

-- b) Invocar la vista creada.
SELECT * FROM vista_artista;

-- c) En la misma invocación de la vista, traer aquellos artistas que tienen menos de 33 filmaciones.

SELECT * FROM vista_artista
HAVING filmaciones < 33;

/*d) Con la misma sentencia anterior, ahora, mostrar el apellido y nombre de los artistas en minúsculas y traer solo aquellos artistas cuyo apellido comience con la letra "a".*/

CREATE VIEW vista_artistas AS
SELECT concat(lower(first_name),' ', lower(last_name)) AS artista, count(*) AS filmaciones FROM film_actor
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE last_name LIKE 'a%'
GROUP BY artista
HAVING filmaciones > 25
ORDER BY last_name;

SELECT * FROM vista_artistas;

-- e) Eliminar la vista creada.

DROP VIEW vista_artistas;

/* 3. a) Crear una vista que devuelva un reporte del título de la película, el apellido y nombre (en una sola columna denominada “artista”) de los artistas y el costo de reemplazo. Traer solo aquellas películas donde su costo de reemplazo es entre 15 y 27 dólares, ordenarlos por costo de reemplazo.*/

CREATE VIEW vista_artista_pelicula AS
SELECT concat(film.title,',',' ', actor.last_name, ' ', actor.first_name) AS artista, film.replacement_cost AS 'Costo_Reemplazo'
FROM actor
INNER JOIN film_actor ON film_actor.actor_id = actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE replacement_cost BETWEEN 15 AND 27;

-- b) Invocar la vista creada.
SELECT * FROM vista_artista_pelicula;

-- c) En la misma invocación de la vista, traer aquellas películas que comienzan con la letra "b".
SELECT * FROM vista_artista_pelicula
WHERE artista LIKE 'b%';

-- d) Modificar la vista creada agregando una condición que traiga los artistas cuyo nombre termine con la letra "a" y ordenarlos por mayor costo de reemplazo.

ALTER VIEW vista_artista_pelicula AS
SELECT  concat(film.title,',',' ', actor.last_name, ' ', actor.first_name) AS artista, film.replacement_cost AS 'Costo_Reemplazo' FROM actor
INNER JOIN film_actor ON film_actor.actor_id = actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE first_name LIKE '%a'
ORDER BY replacement_cost DESC;

-- e) Invocar la vista creada.
SELECT  * FROM vista_artista_pelicula;

DROP VIEW vista_artista_pelicula;
