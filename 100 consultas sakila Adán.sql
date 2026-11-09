-- ==============================================
-- SECCIÓN A) 30 CONSULTAS CON JOIN DE 2 TABLAS
-- ==============================================

-- 1: Para cada actor, muestra el número total de películas en las que aparece; es decir, cuenta cuántas filas de film_actor corresponden a cada actor.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS total_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;

-- 2: Lista solo los actores que participan en 20 o más películas (umbral alto) con su conteo.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS total_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) >= 20;

-- 3: Para cada idioma, indica cuántas películas están catalogadas en ese idioma.
SELECT l.language_id, l.name AS idioma, COUNT(f.film_id) AS total_peliculas
FROM language l
JOIN film f ON l.language_id = f.language_id
GROUP BY l.language_id, l.name;

-- 4: Muestra el promedio de duración (length) de las películas por idioma y filtra aquellos idiomas con duración media estrictamente mayor a 110 minutos.
SELECT l.language_id, l.name AS idioma, AVG(f.length) AS duracion_media
FROM language l
JOIN film f ON l.language_id = f.language_id
GROUP BY l.language_id, l.name
HAVING AVG(f.length) > 110;

-- 5: Para cada película, muestra cuántas copias hay en el inventario.
SELECT f.film_id, f.title, COUNT(i.inventory_id) AS total_copias
FROM film f
JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title;

-- 6: Lista solo las películas que tienen al menos 5 copias en inventario.
SELECT f.film_id, f.title, COUNT(i.inventory_id) AS total_copias
FROM film f
JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
HAVING COUNT(i.inventory_id) >= 5;

-- 7: Para cada artículo de inventario, cuenta cuántos alquileres se han realizado.
SELECT i.inventory_id, COUNT(r.rental_id) AS total_alquileres
FROM inventory i
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY i.inventory_id;

-- 8: Para cada cliente, muestra cuántos alquileres ha realizado en total.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 9: Lista los clientes con 30 o más alquileres acumulados.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(r.rental_id) >= 30;

-- 10: Para cada cliente, muestra el total de pagos (suma en euros/dólares) que ha realizado.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_pagado
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 11: Muestra los clientes cuyo importe total pagado es al menos 200.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_pagado
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(p.amount) >= 200;

-- 12: Para cada empleado (staff), muestra el número de pagos que ha procesado.
SELECT s.staff_id, s.first_name, s.last_name, COUNT(p.payment_id) AS total_pagos
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
GROUP BY s.staff_id, s.first_name, s.last_name;

-- 13: Para cada empleado, muestra el importe total procesado.
SELECT s.staff_id, s.first_name, s.last_name, SUM(p.amount) AS importe_total
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
GROUP BY s.staff_id, s.first_name, s.last_name;

-- 14: Para cada tienda, cuenta cuántos artículos de inventario tiene.
SELECT st.store_id, COUNT(i.inventory_id) AS total_inventario
FROM store st
JOIN inventory i ON st.store_id = i.store_id
GROUP BY st.store_id;

-- 15: Para cada tienda, cuenta cuántos clientes tiene asignados.
SELECT st.store_id, COUNT(c.customer_id) AS total_clientes
FROM store st
JOIN customer c ON st.store_id = c.store_id
GROUP BY st.store_id;

-- 16: Para cada tienda, cuenta cuántos empleados (staff) tiene asignados.
SELECT st.store_id, COUNT(s.staff_id) AS total_empleados
FROM store st
JOIN staff s ON st.store_id = s.store_id
GROUP BY st.store_id;

-- 17: Para cada dirección (address), cuenta cuántas tiendas hay ubicadas ahí (debería ser 0/1 en datos estándar).
SELECT a.address_id, a.address, COUNT(st.store_id) AS total_tiendas
FROM address a
LEFT JOIN store st ON a.address_id = st.address_id
GROUP BY a.address_id, a.address;

-- 18: Para cada dirección, cuenta cuántos empleados residen en esa dirección.
SELECT a.address_id, a.address, COUNT(s.staff_id) AS total_empleados
FROM address a
JOIN staff s ON a.address_id = s.address_id
GROUP BY a.address_id, a.address;

-- 19: Para cada dirección, cuenta cuántos clientes residen ahí.
SELECT a.address_id, a.address, COUNT(c.customer_id) AS total_clientes
FROM address a
JOIN customer c ON a.address_id = c.address_id
GROUP BY a.address_id, a.address;

-- 20: Para cada ciudad, cuenta cuántas direcciones hay registradas.
SELECT ci.city_id, ci.city, COUNT(a.address_id) AS total_direcciones
FROM city ci
JOIN address a ON ci.city_id = a.city_id
GROUP BY ci.city_id, ci.city;

-- 21: Para cada país, cuenta cuántas ciudades existen.
SELECT co.country_id, co.country, COUNT(ci.city_id) AS total_ciudades
FROM country co
JOIN city ci ON co.country_id = ci.country_id
GROUP BY co.country_id, co.country;

-- 22: Para cada idioma, calcula la duración media de películas y muestra solo los idiomas con media entre 90 y 120 inclusive.
SELECT l.language_id, l.name AS idioma, AVG(f.length) AS duracion_media
FROM language l
JOIN film f ON l.language_id = f.language_id
GROUP BY l.language_id, l.name
HAVING AVG(f.length) BETWEEN 90 AND 120;

-- 23: Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).
SELECT i.film_id, COUNT(r.rental_id) AS total_alquileres
FROM inventory i
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY i.film_id;

-- 24: Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).
SELECT c.customer_id, c.first_name, c.last_name, COUNT(p.payment_id) AS pagos_2005
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
WHERE YEAR(p.payment_date) = 2005
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 25: Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).
SELECT f.film_id, f.title, AVG(f.rental_rate) AS promedio_tarifa
FROM film f
JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title;

-- 26: Para cada actor, muestra la duración media (length) de sus películas.
SELECT fa.actor_id, AVG(f.length) AS duracion_media
FROM film_actor fa
JOIN film f ON fa.film_id = f.film_id
GROUP BY fa.actor_id;

-- 27: Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).
SELECT ci.city_id, ci.city, COUNT(a.address_id) AS total_direcciones
FROM city ci
JOIN address a ON ci.city_id = a.city_id
GROUP BY ci.city_id, ci.city;

-- 28: Para cada película, cuenta cuántos actores tiene asociados.
SELECT f.film_id, f.title, COUNT(fa.actor_id) AS total_actores
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY f.film_id, f.title;

-- 29: Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).
SELECT fc.category_id, COUNT(f.film_id) AS total_peliculas
FROM film_category fc
JOIN film f ON fc.film_id = f.film_id
GROUP BY fc.category_id;

-- 30: Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.
SELECT i.store_id, COUNT(r.rental_id) AS total_alquileres
FROM inventory i
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY i.store_id;

-- ==============================================
-- SECCIÓN B) 30 CONSULTAS CON JOIN DE 3 TABLAS
-- ==============================================

-- 31: Para cada actor, cuenta cuántas películas tiene y muestra solo los que superan 15 películas.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(f.film_id) AS total_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(f.film_id) > 15;

-- 32: Para cada categoría (por nombre), cuenta cuántas películas hay en esa categoría.
SELECT c.category_id, c.name AS categoria, COUNT(f.film_id) AS total_peliculas
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name;

-- 33: Para cada película, cuenta cuántos alquileres se han hecho de sus copias.
SELECT f.film_id, f.title, COUNT(r.rental_id) AS total_alquileres
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title;

-- 34: Para cada cliente, suma el importe pagado en 2005 y filtra clientes con total >= 150.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_pagado_2005
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
WHERE YEAR(p.payment_date) = 2005
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(p.amount) >= 150;

-- 35: Para cada tienda, suma el importe cobrado por todos sus empleados.
SELECT st.store_id, SUM(p.amount) AS total_cobrado
FROM store st
JOIN staff s ON st.store_id = s.store_id
JOIN payment p ON s.staff_id = p.staff_id
GROUP BY st.store_id;

-- 36: Para cada ciudad, cuenta cuántos empleados residen ahí (staff -> address -> city).
SELECT ci.city_id, ci.city, COUNT(s.staff_id) AS total_empleados
FROM staff s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city_id, ci.city;

-- 37: Para cada ciudad, cuenta cuántas tiendas existen (store -> address -> city).
SELECT ci.city_id, ci.city, COUNT(st.store_id) AS total_tiendas
FROM store st
JOIN address a ON st.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city_id, ci.city;

-- 38: Para cada actor, calcula la duración media de sus películas del año 2006.
SELECT a.actor_id, a.first_name, a.last_name, AVG(f.length) AS duracion_media_2006
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.release_year = 2006
GROUP BY a.actor_id, a.first_name, a.last_name;

-- 39: Para cada categoría, calcula la duración media y muestra solo las que superan 120.
SELECT c.category_id, c.name AS categoria, AVG(f.length) AS duracion_media
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
HAVING AVG(f.length) > 120;

-- 40: Para cada idioma, suma las tarifas de alquiler (rental_rate) de todas sus películas.
SELECT l.language_id, l.name AS idioma, SUM(f.rental_rate) AS suma_tarifas
FROM language l
JOIN film f ON l.language_id = f.language_id
JOIN inventory i ON f.film_id = i.film_id
GROUP BY l.language_id, l.name;

-- 41: Para cada cliente, cuenta cuántos alquileres realizó en fines de semana (SÁB-DO) usando DAYOFWEEK (1=Domingo).
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS alquileres_finde
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE DAYOFWEEK(r.rental_date) IN (1, 7)
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 42: Para cada actor, muestra el total de títulos distintos en los que participa (equivale a COUNT DISTINCT, sin subconsulta).
SELECT a.actor_id, a.first_name, a.last_name, COUNT(DISTINCT f.title) AS titulos_distintos
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
GROUP BY a.actor_id, a.first_name, a.last_name;

-- 43: Para cada ciudad, cuenta cuántos clientes residen ahí (customer -> address -> city).
SELECT ci.city_id, ci.city, COUNT(cu.customer_id) AS total_clientes
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city_id, ci.city;

-- 44: Para cada categoría, muestra cuántos actores distintos participan en películas de esa categoría.
SELECT c.category_id, c.name AS categoria, COUNT(DISTINCT fa.actor_id) AS actores_distintos
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film_actor fa ON fc.film_id = fa.film_id
GROUP BY c.category_id, c.name;

-- 45: Para cada tienda, cuenta cuántas copias totales (inventario) tiene de películas en 2006.
SELECT st.store_id, COUNT(i.inventory_id) AS copias_2006
FROM store st
JOIN inventory i ON st.store_id = i.store_id
JOIN film f ON i.film_id = f.film_id
WHERE f.release_year = 2006
GROUP BY st.store_id;
-- 46:  Para cada cliente, suma el total pagado por alquileres cuyo empleado pertenece a la tienda 1.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_pagado_tienda1
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN staff s ON p.staff_id = s.staff_id
WHERE s.store_id = 1
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 47:  Para cada película, cuenta cuántos actores tienen el apellido de longitud >= 5.
SELECT f.film_id, f.title, COUNT(a.actor_id) AS actores_apellido_largo
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE CHAR_LENGTH(a.last_name) >= 5
GROUP BY f.film_id, f.title;

-- 48:  Para cada categoría, suma la duración total (length) de sus películas.
SELECT c.category_id, c.name AS categoria, SUM(f.length) AS duracion_total
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name;

-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.
SELECT a.city_id, SUM(p.amount) AS total_pagado
FROM address a
JOIN customer cu ON a.address_id = cu.address_id
JOIN payment p ON cu.customer_id = p.customer_id
GROUP BY a.city_id;

-- 50:  Para cada idioma, cuenta cuántos actores distintos participan en películas de ese idioma.
SELECT l.language_id, l.name AS idioma, COUNT(DISTINCT fa.actor_id) AS actores_distintos
FROM language l
JOIN film f ON l.language_id = f.language_id
JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY l.language_id, l.name;

-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.
SELECT st.store_id, COUNT(cu.customer_id) AS clientes_activos
FROM store st
JOIN address a ON st.address_id = a.address_id
JOIN customer cu ON st.store_id = cu.store_id
WHERE cu.active = 1
GROUP BY st.store_id;

-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).
-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.
-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.
-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas.
-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).
-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.
-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.
-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.
-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.
-- ==============================================
-- SECCIÓN C) 20 CONSULTAS CON JOIN DE 4 TABLAS
-- ==============================================
-- 61:  Para cada ciudad, cuenta cuántos clientes hay y muestra solo ciudades con 10 o más clientes.
-- 62:  Para cada actor, cuenta cuántos alquileres totales suman todas sus películas.
-- 63:  Para cada categoría, suma los importes pagados derivados de películas de esa categoría.
-- 64:  Para cada ciudad, suma los importes pagados por clientes residentes en esa ciudad en 2005.
-- 65:  Para cada tienda, cuenta cuántos actores distintos aparecen en las películas de su inventario.
-- 66:  Para cada idioma, cuenta cuántos alquileres totales se han hecho de películas en ese idioma.
-- 67:  Para cada cliente, cuenta en cuántos meses distintos de 2005 realizó pagos (meses distintos).
-- 68:  Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).
-- 69:  Para cada país, cuenta cuántos clientes hay (country -> city -> address -> customer).
-- 70:  Para cada país, suma los importes pagados por sus clientes.
-- 71:  Para cada tienda, cuenta cuántas categorías distintas existen en su inventario.
-- 72:  Para cada tienda, suma la recaudación por categoría (resultado agregado por tienda y categoría).
-- 73:  Para cada actor, cuenta en cuántas tiendas distintas se han alquilado sus películas.
-- 74:  Para cada categoría, cuenta cuántos clientes distintos han alquilado películas de esa categoría.
-- 75:  Para cada idioma, cuenta cuántos actores distintos participan en películas alquiladas en ese idioma.
-- 76:  Para cada país, cuenta cuántas tiendas hay (país->ciudad->address->store).
-- 77:  Para cada cliente, cuenta los alquileres en los que la devolución (return_date) fue el mismo día del alquiler.
-- 78:  Para cada tienda, cuenta cuántos clientes distintos realizaron pagos en 2005.
-- 79:  Para cada categoría, cuenta cuántas películas con título de longitud > 15 han sido alquiladas.
-- 80:  Para cada país, suma los pagos procesados por los empleados de las tiendas ubicadas en ese país.
-- ==============================================
-- SECCIÓN D) 20 CONSULTAS EXTRA (DIFICULTAD +), <=4 JOINS
-- ==============================================
-- 81:  Para cada cliente, muestra el total pagado con IVA teórico del 21% aplicado (total*1.21), redondeado a 2 decimales.
-- 82:  Para cada hora del día (0-23), cuenta cuántos alquileres se iniciaron en esa hora.
-- 83:  Para cada tienda, muestra la media de length de las películas alquiladas en 2005 y filtra las tiendas con media >= 100.
-- 84:  Para cada categoría, muestra la media de replacement_cost de las películas alquiladas un domingo.
-- 85:  Para cada empleado, muestra el importe total por pagos realizados entre las 00:00 y 06:00 (inclusive 00:00, exclusivo 06:00).
-- 86:  Para cada actor, cuenta cuántas de sus películas tienen un título que contiene la palabra 'LOVE' (mayúsculas).
-- 87:  Para cada idioma, muestra el total de pagos de alquileres de películas en ese idioma.
-- 88:  Para cada cliente, cuenta en cuántos días distintos de 2005 realizó algún alquiler.
-- 89:  Para cada categoría, calcula la longitud media de títulos (número de caracteres) de sus películas alquiladas.
-- 90:  Para cada tienda, cuenta cuántos clientes distintos alquilaron en el primer trimestre de 2006 (enero-marzo).
-- 91:  Para cada país, cuenta cuántas categorías diferentes han sido alquiladas por clientes residentes en ese país.
-- 92:  Para cada cliente, muestra el importe medio de sus pagos redondeado a 2 decimales, solo si ha hecho al menos 10 pagos.
-- 93:  Para cada categoría, muestra el número de películas con replacement_cost > 20 que hayan sido alquiladas al menos una vez.
-- 94:  Para cada tienda, suma los importes pagados en fines de semana.
-- 95:  Para cada actor, cuenta cuántas películas suyas fueron alquiladas por al menos 5 clientes distintos (se cuenta alquileres y luego se filtra por HAVING).
-- 96:  Para cada idioma, muestra el número de películas cuyo título empieza por la letra 'A' y que han sido alquiladas.
-- 97:  Para cada país, suma el importe total de pagos realizados por clientes residentes y filtra países con total >= 1000.
-- 98:  Para cada cliente, cuenta cuántos días han pasado entre su primer y su último alquiler en 2005 (diferencia de fechas), mostrando solo clientes con >= 5 alquileres en 2005.
--     (Se evita subconsulta calculando sobre el conjunto agrupado por cliente y usando MIN/MAX de rental_date en 2005).
-- 99:  Para cada tienda, muestra la media de importes cobrados por transacción en el año 2006, con dos decimales.
-- 100:  Para cada categoría, calcula la media de duración (length) de películas alquiladas en 2006 y ordénalas descendentemente por dicha media.