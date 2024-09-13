/*добавьте сюда запрос для решения задания 2*/

-- Название бренда и средняя цену его автомобилей в разбивке по всем годам с учётом скидки
SELECT
	b."name" AS brand_name,
	EXTRACT(YEAR FROM s."date") AS "year",
	ROUND(AVG(s.price), 2) AS price_avg
FROM car_shop.cars AS c
INNER JOIN car_shop.brands AS b ON b.id = c.brand_id
INNER JOIN car_shop.sales AS s ON s.car_id = c.id
GROUP BY b."name", EXTRACT(YEAR FROM s."date")
ORDER BY brand_name, "year";