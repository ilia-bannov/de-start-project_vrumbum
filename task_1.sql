/*добавьте сюда запрос для решения задания 1*/

-- процент электрокаров
SELECT
	100 - ((COUNT(gasoline_consumption) * 100)::REAL / COUNT(*))::NUMERIC(5,2) AS nulls_percentage_gasoline_consumption
FROM car_shop.cars;