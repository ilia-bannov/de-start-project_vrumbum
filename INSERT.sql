/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме автосалона*/

INSERT INTO car_shop.colors(name) SELECT DISTINCT color FROM raw_data.sales_extended;

INSERT INTO car_shop.countries(name) SELECT DISTINCT brand_origin AS country FROM raw_data.sales WHERE brand_origin IS NOT NULL;

INSERT INTO car_shop.brands(name, origin_country_id)
SELECT DISTINCT
	s.brand,
	c.id AS origin_country_id
FROM raw_data.sales_extended s
LEFT JOIN car_shop.countries c ON c."name" = s.brand_origin;

INSERT INTO car_shop.clients(first_name, last_name, medical_degree, title, phone)
SELECT DISTINCT
	first_name,
	last_name,
	medical_degree,
	title,
	phone
FROM raw_data.sales_extended;

INSERT INTO car_shop.cars("name", brand_id, gasoline_consumption)
SELECT DISTINCT
	s.car_name,
	b.id AS brand_id,
	s.gasoline_consumption
FROM raw_data.sales_extended s
LEFT JOIN car_shop.brands b ON b."name" = s.brand;

INSERT INTO car_shop.cars_colors(car_id, color_id)
SELECT DISTINCT
	c.id AS car_id,
	col.id AS color_id 
FROM car_shop.cars c
JOIN car_shop.brands b ON b.id = c.brand_id
JOIN raw_data.sales_extended s ON s.brand = b."name" AND s.car_name = c."name" AND s.gasoline_consumption = c.gasoline_consumption
JOIN car_shop.colors col ON col."name" = s.color;

INSERT INTO car_shop.sales(car_id, client_id, price, net_price, discount, "date")
SELECT
	c.id AS car_id,
	cl.id AS client_id,
	s.price,
	s.net_price,
	s.discount,
	s."date"
FROM car_shop.cars c
JOIN car_shop.brands b ON b.id = c.brand_id
JOIN raw_data.sales_extended s ON s.brand = b."name" AND s.car_name = c."name" AND s.gasoline_consumption = c.gasoline_consumption
JOIN car_shop.clients cl ON cl.phone = s.phone;