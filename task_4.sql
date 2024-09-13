/*добавьте сюда запрос для решения задания 4*/

-- Список клиентов и приобретенных автомобилей
SELECT
	cl.first_name || ' ' || cl.last_name AS person,
	STRING_AGG(b."name" || ' ' || c."name", ', ') AS cars
FROM car_shop.sales AS s
INNER JOIN car_shop.clients AS cl ON cl.id = s.client_id
INNER JOIN car_shop.cars AS c ON c.id = s.car_id
INNER JOIN car_shop.brands AS b ON b.id = c.brand_id
GROUP BY cl.first_name || ' ' || cl.last_name
ORDER BY person ASC;