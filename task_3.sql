/*добавьте сюда запрос для решения задания 3*/

-- Средняя цена всех автомобилей с разбивкой по месяцам в 2022 году с учётом скидки
SELECT
	EXTRACT(MONTH FROM "date") AS "month",
	EXTRACT(YEAR FROM "date") AS "year",
	ROUND(AVG(price), 2) AS avg_price
FROM car_shop.sales
WHERE EXTRACT(YEAR FROM "date") = '2022'
GROUP BY EXTRACT(MONTH FROM "date"), EXTRACT(YEAR FROM "date")
ORDER BY "month" ASC;