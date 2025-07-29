-- Clase N°13

use sakila; 

-- 1. AGREGAR UN NUEVO CLIENTE A STORE 1
INSERT INTO customer (
    store_id,
    first_name,
    last_name,
    email,
    address_id,
    active,
    create_date
)
VALUES (
    1,
    'Juan',
    'Pérez',
    'juan.perez@example.com',
    (
        SELECT address_id
        FROM address
        WHERE address_id = (
            SELECT MAX(address_id)
            FROM address
            JOIN city USING(city_id)
            JOIN country USING(country_id)
            WHERE country.country = 'United States'
        )
    ),
    1,
    NOW()
);

-- 2. Agregar un alquiler (rental)
INSERT INTO rental (
    rental_date,
    inventory_id,
    customer_id,
    staff_id
)
VALUES (
    NOW(),
    (
        SELECT MAX(inventory_id)
        FROM inventory
        WHERE film_id = (
            SELECT film_id
            FROM film
            WHERE title = 'ACADEMY DINOSAUR'
            LIMIT 1
        )
    ),
    (
        SELECT customer_id
        FROM customer
        ORDER BY customer_id DESC
        LIMIT 1
    ),
    (
        SELECT staff_id
        FROM staff
        WHERE store_id = 2
        LIMIT 1
    )
);


-- 3. ACTUALIZAR AÑO DE PELÍCULAS SEGÚN RATING
UPDATE film SET release_year = 2001 WHERE rating = 'G';
UPDATE film SET release_year = 2002 WHERE rating = 'PG';
UPDATE film SET release_year = 2003 WHERE rating = 'PG-13';
UPDATE film SET release_year = 2004 WHERE rating = 'R';
UPDATE film SET release_year = 2005 WHERE rating = 'NC-17';

-- 4. DEVOLVER UNA PELÍCULA
UPDATE rental
SET return_date = NOW()
WHERE rental_id = (
    SELECT rental_id
    FROM rental
    WHERE return_date IS NULL
    ORDER BY rental_date DESC
    LIMIT 1
);


-- 5. ELIMINAR UNA PELÍCULA COMPLETAMENTE

-- Eliminar pagos relacionados
DELETE FROM payment
WHERE rental_id IN (
    SELECT rental_id
    FROM rental
    WHERE inventory_id IN (
        SELECT inventory_id
        FROM inventory
        WHERE film_id = (
            SELECT film_id
            FROM film
            WHERE title = 'Film Title'
            LIMIT 1
        )
    )
);

-- Eliminar alquileres relacionados
DELETE FROM rental
WHERE inventory_id IN (
    SELECT inventory_id
    FROM inventory
    WHERE film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Film Title'
        LIMIT 1
    )
);

-- Eliminar registros de inventario
DELETE FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Film Title'
    LIMIT 1
);

-- Eliminar relaciones con actores
DELETE FROM film_actor
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Film Title'
    LIMIT 1
);

-- Eliminar relaciones con categorías
DELETE FROM film_category
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Film Title'
    LIMIT 1
);

-- Finalmente eliminar la película
DELETE FROM film
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Film Title'
    LIMIT 1
);

-- 6. ALQUILAR UNA PELÍCULA

-- Paso 1: obtener un inventory_id disponible
	SELECT inventory_id FROM inventory
	WHERE inventory_id NOT IN (
		SELECT inventory_id FROM rental WHERE return_date IS NULL
	)
	LIMIT 1;
-- Suponiendo que el resultado fue 9999:

INSERT INTO rental (
    rental_date,
    inventory_id,
    customer_id,
    staff_id
)
VALUES (
    NOW(),
    9999,
    (
        SELECT customer_id
        FROM customer
        ORDER BY customer_id DESC
        LIMIT 1
    ),
    (
        SELECT staff_id
        FROM staff
        ORDER BY staff_id DESC
        LIMIT 1
    )
);

-- Insertar pago correspondiente
INSERT INTO payment (
    customer_id,
    staff_id,
    rental_id,
    amount,
    payment_date
)
VALUES (
    (
        SELECT customer_id
        FROM customer
        ORDER BY customer_id DESC
        LIMIT 1
    ),
    (
        SELECT staff_id
        FROM staff
        ORDER BY staff_id DESC
        LIMIT 1
    ),
    (
        SELECT rental_id
        FROM rental
        ORDER BY rental_id DESC
        LIMIT 1
    ),
    4.99,
    NOW()
);