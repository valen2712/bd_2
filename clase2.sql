CREATE DATABASE imdb;
USE imdb;

CREATE TABLE IF NOT EXISTS film (
    film_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_year YEAR,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS actor (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS film_actor (
    actor_id INT,
    film_id INT,
    PRIMARY KEY (actor_id, film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

INSERT INTO film (title, description, release_year) VALUES
('The Matrix', 'Sci-fi action movie', 1999),
('Inception', 'Mind-bending thriller', 2010),
('Interstellar', 'Space exploration epic', 2014);

INSERT INTO actor (first_name, last_name) VALUES
('Keanu', 'Reeves'),
('Leonardo', 'DiCaprio'),
('Matthew', 'McConaughey');

INSERT INTO film_actor (actor_id, film_id) VALUES
(1, 1), -- Keanu Reeves en The Matrix
(2, 2), -- Leonardo DiCaprio en Inception
(3, 3); -- Matthew McConaughey en Interstellar

select * from film_actor;