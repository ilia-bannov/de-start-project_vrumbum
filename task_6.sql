/*добавьте сюда запрос для решения задания 6*/

-- Количество клиентов из США
SELECT COUNT(*) AS persons_from_usa_count
FROM car_shop.clients
WHERE SUBSTR(phone, 1, 2) = '+1'; -- у клиентов из США телефонный номер начинается с +1