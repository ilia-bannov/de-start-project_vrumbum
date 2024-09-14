/*Добавьте в этот файл все запросы, для создания схемы данных автосалона и
 таблиц в ней в нужном порядке*/

CREATE SCHEMA IF NOT EXISTS car_shop;

--DROP TABLE IF EXISTS car_shop.clients CASCADE;
--DROP TABLE IF EXISTS car_shop.countries CASCADE;
--DROP TABLE IF EXISTS car_shop.brands CASCADE;
--DROP TABLE IF EXISTS car_shop.colors CASCADE;
--DROP TABLE IF EXISTS car_shop.cars CASCADE;
--DROP TABLE IF EXISTS car_shop.cars_colors CASCADE;
--DROP TABLE IF EXISTS car_shop.sales CASCADE;

CREATE TABLE IF NOT EXISTS car_shop.clients (
	id SERIAL PRIMARY KEY, /* первичный ключ с автоинкрементом, клиентов потенциально может быть много поэтому SERIAL */
	first_name TEXT NOT NULL, /* имя клиента состоит из букв поэтому TEXT */
	last_name TEXT NOT NULL, /* фамилия клиента состоит из букв поэтому TEXT */
	medical_degree VARCHAR(10), /* медицинская степень абревиатура VARCHAR(10) должно хватить */
	title VARCHAR(10), /* сокращенная форма обращения VARCHAR(10) должно хватить */
	phone TEXT NOT NULL UNIQUE /* номер телефона состоит цифр и символом поэтому TEXT, по заданию телефон не меняется, поэтому считаем что он уникален */
);

CREATE TABLE IF NOT EXISTS car_shop.countries (
	id SMALLSERIAL PRIMARY KEY, /* первичный ключ с автоинкрементом, для стран должно хватить SMALLSERIAL */
	name TEXT NOT NULL UNIQUE /* названия страны состоит из букв поэтому TEXT, названия стран повторяться не могут */
);

CREATE TABLE IF NOT EXISTS car_shop.brands (
	id SMALLSERIAL PRIMARY KEY, /* первичный ключ с автоинкрементом, для брэндов автомобилей должно хватить SMALLSERIAL */
	name TEXT NOT NULL UNIQUE, /* названия бренда состоит из букв поэтому TEXT, названия брэндов повторяться не могут */
	origin_country_id SMALLINT REFERENCES car_shop.countries /* внешний ключ, тип такой же как у ключа на который он ссылается */
);

CREATE TABLE IF NOT EXISTS car_shop.colors (
	id SERIAL PRIMARY KEY, /* первичный ключ с автоинкрементом, цветов и их оттенков потенциально может быть много поэтому SERIAL */
	name TEXT NOT NULL UNIQUE /* названия цветов и их оттенков состоят из букв поэтому TEXT */
);

CREATE TABLE IF NOT EXISTS car_shop.cars (
	id SERIAL PRIMARY KEY, /* первичный ключ с автоинкрементом, автомобилей потенциально может быть много поэтому SERIAL */
	name TEXT NOT NULL, /* названия автомобилей состоят из букв и цифр поэтому TEXT */
	brand_id SMALLINT REFERENCES car_shop.brands, /* внешний ключ, тип такой же как у ключа на который он ссылается */
	gasoline_consumption NUMERIC(3,1) NOT NULL DEFAULT 0, /* для электрокаров значения равно 0, по заданию потребление бензина не может быть трех значным. У numeric повышенная точность при работе с дробными числами, поэтому при операциях c этим типом данных, дробные числа не потеряются. */
	UNIQUE(name, brand_id, gasoline_consumption) /* названия автомобиля, бренд и потребление топлива повторяться не могут */
);

CREATE TABLE IF NOT EXISTS car_shop.cars_colors (
	id SERIAL PRIMARY KEY, /* первичный ключ с автоинкрементом, сочетаний автомобилей и цветов потенциально может быть много поэтому SERIAL */
	car_id INTEGER REFERENCES car_shop.cars, /* внешний ключ, тип такой же как у ключа на который он ссылается */
	color_id INTEGER REFERENCES car_shop.colors, /* внешний ключ, тип такой же как у ключа на который он ссылается */
	UNIQUE(car_id, color_id) /* сочетание одного и того же автомобиля и цвета повторяться не могут */
);

CREATE TABLE IF NOT EXISTS car_shop.sales (
	id SERIAL PRIMARY KEY, /* первичный ключ с автоинкрементом, продаж потенциально может быть много поэтому SERIAL */
	car_id INTEGER REFERENCES car_shop.cars, /* внешний ключ, тип такой же как у ключа на который он ссылается */
	client_id INTEGER REFERENCES car_shop.clients, /* внешний ключ, тип такой же как у ключа на который он ссылается */
	price NUMERIC(9,2) NOT NULL, /* цена может содержать только сотые и не может быть больше семизначной суммы. У numeric повышенная точность при работе с дробными числами, поэтому при операциях c этим типом данных, дробные числа не потеряются. */
	net_price NUMERIC(9,2) NOT NULL, /* цена без учета скидки */
	discount SMALLINT DEFAULT 0 CHECK(discount >= 0 AND discount <= 100), /* скидка в процентах от 0 до 100 поэтому SMALLINT */
	"date" DATE NOT NULL DEFAULT CURRENT_DATE, /* дата продажи без времени поэтому DATE */
	UNIQUE(car_id, client_id, "date") /* сочетание проданного автомобиля, покупателя и даты продажи уникально*/
);