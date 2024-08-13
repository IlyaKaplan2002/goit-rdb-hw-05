USE mydb;

SELECT od.*, (
        SELECT o.customer_id
        FROM orders o
        WHERE
            o.id = od.order_id
    ) AS customer_id
FROM order_details od;

SELECT *
FROM order_details od
WHERE
    od.order_id IN (
        SELECT o.id
        FROM orders o
        WHERE
            o.shipper_id = 3
    );

SELECT order_id, AVG(quantity) AS avg_quantity
FROM (
        SELECT *
        FROM order_details
        WHERE
            quantity > 10
    ) AS tmp_table
GROUP BY
    order_id;

WITH
    tmp_table AS (
        SELECT *
        FROM order_details
        WHERE
            quantity > 10
    )
SELECT order_id, AVG(quantity) AS avg_quantity
FROM tmp_table
GROUP BY
    order_id;

DROP FUNCTION IF EXISTS divide_floats;

delimiter / /

CREATE FUNCTION divide_floats(a FLOAT, b FLOAT)
RETURNS FLOAT
NO SQL
DETERMINISTIC
BEGIN
    RETURN a / b;
END;//

delimiter;

SELECT
    quantity,
    divide_floats (quantity, 2.0) AS divided_quantity
FROM order_details;