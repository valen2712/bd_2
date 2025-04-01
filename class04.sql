-- 1. Mostrar título y special_features de películas que son PG-13
SELECT title, special_features FROM film WHERE rating = 'PG-13';

-- 2. Obtener una lista de todas las diferentes duraciones de películas (suponiendo que hay una columna duration)
SELECT DISTINCT duration FROM film;

-- 3. Mostrar título, rental_rate y replacement_cost de películas con replacement_cost entre 20.00 y 24.00
SELECT title, rental_rate, replacement_cost FROM film WHERE replacement_cost BETWEEN 20.00 AND 24.00;

-- 4. Mostrar título, categoría y rating de películas que tienen 'Behind the Scenes' como special_features
SELECT title, category, rating FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE special_features LIKE '%Behind the Scenes%';

-- 5. Mostrar nombre y apellido de actores que actuaron en 'ZOOLANDER FICTION'
SELECT actor.first_name, actor.last_name FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'ZOOLANDER FICTION';

-- 6. Mostrar dirección, ciudad y país de la tienda con id 1
SELECT address.address, city.city, country.country FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE store.store_id = 1;

-- 7. Mostrar pares de títulos de películas con el mismo rating
SELECT f1.title AS film1, f2.title AS film2, f1.rating FROM film f1
JOIN film f2 ON f1.rating = f2.rating AND f1.film_id < f2.film_id;

-- 8. Obtener todas las películas disponibles en la tienda 2 y el nombre del gerente
SELECT film.title, staff.first_name, staff.last_name FROM inventory
JOIN film ON inventory.film_id = film.film_id
JOIN store ON inventory.store_id = store.store_id
JOIN staff ON store.manager_staff_id = staff.staff_id
WHERE inventory.store_id = 2;
