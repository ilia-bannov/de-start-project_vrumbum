/*добавьте сюда запрос для решения задания 5*/

-- Максимальная и минимальная цена без учета скидок по странам бренда
SELECT
	cn."name" AS brand_origin,
	MAX(s.net_price) AS price_max,
	MIN(s.net_price) AS price_min
FROM car_shop.sales AS s
INNER JOIN car_shop.cars AS c ON c.id = s.car_id
INNER JOIN car_shop.brands AS b ON b.id = c.brand_id
INNER JOIN car_shop.countries cn ON cn.id = b.origin_country_id
GROUP BY cn."name";