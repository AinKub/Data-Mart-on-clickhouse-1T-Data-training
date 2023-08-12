CREATE DATABASE IF NOT EXISTS markets ENGINE = Atomic;

CREATE TABLE IF NOT EXISTS markets.shops (
	shop_id UInt32,
	shop_name String
)
ENGINE = MergeTree()
ORDER BY shop_id;


CREATE TABLE IF NOT EXISTS markets.products (
	product_id UInt32,
	product_name String,
	price Decimal64(2)
)
ENGINE = MergeTree()
ORDER BY product_id;


CREATE TABLE IF NOT EXISTS markets.plan (
	product_id UInt32,
	shop_id UInt32, 
	plan_cnt UInt32,
	plan_date DATE
)
ENGINE = MergeTree()
PRIMARY KEY tuple()
ORDER BY (plan_date, shop_id);


CREATE TABLE IF NOT EXISTS markets.shop_dns (
	"date" DATE DEFAULT current_date(),
	product_id UInt32,
	sales_cnt UInt32
)
ENGINE = MergeTree()
PRIMARY KEY tuple()
ORDER BY ("date", product_id);


CREATE TABLE IF NOT EXISTS markets.shop_mvideo (
	"date" DATE DEFAULT current_date(),
	product_id UInt32,
	sales_cnt UInt32
)
ENGINE = MergeTree()
PRIMARY KEY tuple()
ORDER BY ("date", product_id);


CREATE TABLE IF NOT EXISTS markets.shop_sitilink (
	"date" DATE DEFAULT current_date(),
	product_id UInt32,
	sales_cnt UInt32
)
ENGINE = MergeTree()
PRIMARY KEY tuple()
ORDER BY ("date", product_id);


INSERT INTO markets.shops (shop_id, shop_name)
VALUES (1, 'dns'), (2, 'mvideo'), (3, 'sitilink');


INSERT INTO markets.products (product_id, product_name, price)
VALUES(1, 'Broken phone', 1000), (2, 'Word of mouth', 2999.99), (3, 'Turntable', 4999.49);


INSERT INTO markets.plan (product_id, shop_id, plan_cnt, plan_date)
VALUES(1, 1, 10, '2023-07-31'),
      (2, 1, 6, '2023-07-31'),
      (3, 1, 7, '2023-07-31'),
      (1, 2, 20, '2023-07-31'),
      (3, 2, 15, '2023-07-31'),
      (2, 3, 30, '2023-07-31');


INSERT INTO markets.shop_dns
("date", product_id, sales_cnt)
VALUES('2023-07-10', 1, 4),
      ('2023-07-12', 3, 1),
      ('2023-07-15', 1, 6),
      ('2023-07-15', 2, 2),
      ('2023-07-23', 1, 2),
      ('2023-07-26', 3, 2),
      ('2023-07-29', 2, 5);


INSERT INTO markets.shop_mvideo
("date", product_id, sales_cnt)
VALUES('2023-07-10', 1, 10),
      ('2023-07-10', 3, 4),
      ('2023-07-16', 3, 2),
      ('2023-07-20', 1, 4),
      ('2023-07-20', 3, 6),
      ('2023-07-27', 3, 7),
      ('2023-07-29', 1, 5);


INSERT INTO markets.shop_sitilink
("date", product_id, sales_cnt)
VALUES('2023-07-15', 2, 10),
      ('2023-07-20', 2, 10),
      ('2023-07-29', 2, 10);




