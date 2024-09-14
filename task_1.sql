/*добавьте сюда запрос для решения задания 1*/

-- процент электрокаров
SELECT
	((COUNT(CASE WHEN gasoline_consumption = 0 THEN 1 END) * 100)::REAL / COUNT(*))::NUMERIC(5,2) AS nulls_percentage_gasoline_consumption
FROM car_shop.cars;