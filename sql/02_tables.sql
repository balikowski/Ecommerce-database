BEGIN;

-- Customers
CREATE TABLE shopflow.Customers (
	customer_id BIGINT PRIMARY KEY,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	email TEXT NOT NULL,
	tel_num VARCHAR(11),
	country TEXT NOT NULL,
	city TEXT NOT NULL,
	is_active BOOLEAN DEFAULT TRUE,
	created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Orders
CREATE TABLE shopflow.Orders (
	order_id BIGINT PRIMARY KEY,
	customer_id BIGINT NOT NULL,
	order_ts TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
	total_amount NUMERIC(8,2) NOT NULL,
	discount_code_id BIGINT DEFAULT NULL
);

-- Order_status_history
CREATE TABLE shopflow.Order_status_history (
	order_status_history_id BIGINT PRIMARY KEY,
	order_id BIGINT NOT NULL,
	order_status_id BIGINT NOT NULL,
	status_from TIMESTAMPTZ NOT NULL,
	status_to TIMESTAMPTZ DEFAULT NULL
);

-- Order_status
CREATE TABLE shopflow.Order_status (
	order_status_id BIGINT PRIMARY KEY,
	status_name TEXT NOT NULL
);

-- Discount_codes
CREATE TABLE shopflow.Discount_codes (
	discount_code_id BIGINT PRIMARY KEY,
	code VARCHAR(10) NOT NULL,
	percent_discount INT NOT NULL,
	valid_from TIMESTAMPTZ NOT NULL,
	valid_to TIMESTAMPTZ
);

-- Payment_methods
CREATE TABLE shopflow.Payment_methods (
	payment_method_id BIGINT PRIMARY KEY,
	payment_method_name TEXT NOT NULL
);

-- Payment_results 
CREATE TABLE shopflow.Payment_results (
	payment_result_id BIGINT PRIMARY KEY,
	payment_result_name TEXT NOT NULL
);

-- Payment_attemps 
CREATE TABLE shopflow.Payment_attemps (
	payment_attempt_id BIGINT PRIMARY KEY,
	payment_method_id BIGINT NOT NULL,
	payment_result_id BIGINT NOT NULL,
	order_id BIGINT NOT NULL,
	amount NUMERIC(8,2),
	payment_attempt_ts TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Warehouses
CREATE TABLE shopflow.Warehouses (
	warehouse_id BIGINT PRIMARY KEY,
	warehouse_name TEXT NOT NULL,
	city TEXT NOT NULL
);

-- Products
CREATE TABLE shopflow.Products (
	product_id BIGINT PRIMARY KEY,
	SKU VARCHAR(8) NOT NULL,
	product_name TEXT NOT NULL,
	weight_in_grams INT,
	product_cost NUMERIC(8,2),
	manufacturer TEXT,
	is_active BOOLEAN NOT NULL DEFAULT TRUE,
	category_id BIGINT NOT NULL
);

-- Order_items
CREATE TABLE shopflow.Order_items (
	order_items_id BIGINT PRIMARY KEY,
	order_id BIGINT NOT NULL,
	product_id BIGINT NOT NULL,
	quantity BIGINT NOT NULL,
	unit_price NUMERIC(8,2) NOT NULL,
	total_amount NUMERIC(8,2) NOT NULL
);

-- Stocking
CREATE TABLE shopflow.Stocking (
	warehouse_id BIGINT NOT NULL,
	product_id BIGINT NOT NULL,
	quantity BIGINT NOT NULL,
	PRIMARY KEY (warehouse_id, product_id)
);

-- Price_history
CREATE TABLE shopflow.Price_history (
	price_history_id BIGINT PRIMARY KEY,
	product_id BIGINT NOT NULL,
	amount NUMERIC(8,2) NOT NULL,
	valid_from TIMESTAMPTZ NOT NULL,
	valid_to TIMESTAMP
);

-- Categories
CREATE TABLE shopflow.Categories (
	category_id BIGINT PRIMARY KEY,
	category_name TEXT NOT NULL
);

-- Shipment_methods
CREATE TABLE shopflow.Shipment_methods (
	shipment_method_id BIGINT PRIMARY KEY,
	shipment_method_name TEXT NOT NULL,
	pred_delivery_days INT
);

-- Shipment_status
CREATE TABLE shopflow.Shipment_status (
	shipment_status_id BIGINT PRIMARY KEY,
	shipment_status_name TEXT NOT NULL
);

-- Shipments
CREATE TABLE shopflow.Shipments (
	shipment_id BIGINT PRIMARY KEY,
	order_id BIGINT NOT NULL,
	shipment_method_id BIGINT NOT NULL
);

-- Shipment_status_history
CREATE TABLE shopflow.Shipment_status_history (	
	shipment_status_history_id BIGINT PRIMARY KEY,
	shipment_id BIGINT NOT NULL,
	shipment_status_id BIGINT NOT NULL,
	status_from TIMESTAMPTZ NOT NULL,
	status_to TIMESTAMPTZ
);


COMMIT;