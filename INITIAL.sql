/*сохраните в этом файле запросы для первоначальной загрузки данных - создание схемы raw_data и таблицы sales и наполнение их данными из csv файла*/

CREATE SCHEMA IF NOT EXISTS raw_data;
CREATE TABLE IF NOT EXISTS raw_data.sales (
	id INTEGER PRIMARY KEY,
	auto TEXT,
	gasoline_consumption NUMERIC(3,1),
	price NUMERIC(9,2),
	date DATE,
	person_name TEXT,
	phone TEXT,
	discount SMALLINT,
	brand_origin TEXT
);

\copy raw_data.sales(id,auto,gasoline_consumption,price,date,person_name,phone,discount,brand_origin) FROM 'C:\Temp\cars.csv' DELIMITER ',' NULL AS 'null' CSV HEADER;

--DROP TABLE IF EXISTS raw_data.sales_extended;
CREATE TABLE raw_data.sales_extended AS
SELECT
	id,
	auto,
	brand,
	TRIM(REPLACE(brand_and_car_name, brand, '')) AS car_name,
	color,
	gasoline_consumption,
	price,
	net_price,
	"date",
	person_name,
	title,
	medical_degree,
	CASE
		WHEN title IS NULL THEN SPLIT_PART(person_name, ' ', 1)
		WHEN title IS NOT NULL THEN SPLIT_PART(person_name, ' ', 2)
	END AS first_name,
    REGEXP_REPLACE(TRIM(REPLACE(REPLACE(person_name, COALESCE(title, ''), ''), COALESCE(medical_degree, ''), '')), '.*?\s', '') AS last_name,
	discount,
	brand_origin
FROM (
	SELECT
		id,
		auto,
		SPLIT_PART(auto, ' ', 1) AS brand,
		SPLIT_PART(auto, ', ', 1) AS brand_and_car_name,
		INITCAP(SPLIT_PART(auto, ', ', 2)) AS color,
		gasoline_consumption,
		price,
		((price * 100)::REAL / (100 - discount))::NUMERIC(9,2) AS net_price,
		"date",
		person_name,
		CASE
			WHEN SPLIT_PART(person_name, ' ', 1) IN ('Mr.', 'Mrs.', 'Miss', 'Dr.', 'Ms.') 
			THEN SPLIT_PART(person_name, ' ', 1)
		END AS title,
		CASE
			WHEN SPLIT_PART(person_name, ' ', 3) IN ('MD', 'DVM', 'DDS')
			THEN SPLIT_PART(person_name, ' ', 3)
			WHEN SPLIT_PART(person_name, ' ', 4) IN ('MD', 'DVM', 'DDS')
			THEN SPLIT_PART(person_name, ' ', 4)
		END AS medical_degree,
		phone,
		discount,
		brand_origin
	FROM raw_data.sales
) s;
