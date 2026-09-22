BEGIN;
-- Customers (PK) - (FK) Orders
ALTER TABLE shopflow.Orders 
ADD CONSTRAINT fk_Orders_Customers
FOREIGN KEY (customer_id) REFERENCES shopflow.Customers(customer_id);

-- Order_status (PK) - (FK) Order_status_history 
ALTER TABLE shopflow.Order_status_history
ADD CONSTRAINT fk_Order_status_history_Order_status
FOREIGN KEY (order_status_id) REFERENCES shopflow.Order_status(order_status_id);

-- Order (PK) - (FK) Order_status_history 
ALTER TABLE shopflow.Order_status_history
ADD CONSTRAINT fk_Order_status_history_Orders
FOREIGN KEY (order_id) REFERENCES shopflow.Orders(order_id);

-- Discount_codes (PK) - (FK) Orders
ALTER TABLE shopflow.Orders 
ADD CONSTRAINT fk_Orders_Discounts_codes
FOREIGN KEY (discount_code_id) REFERENCES shopflow.Discount_codes(discount_code_id);

-- Shipment_methods (PK) - (FK) Shipments
ALTER TABLE shopflow.Shipments
ADD CONSTRAINT fk_Shipments_Shipment_methods
FOREIGN KEY (shipment_method_id) REFERENCES shopflow.Shipment_methods(shipment_method_id);

-- Orders (PK) - (FK) Order_items
ALTER TABLE shopflow.Order_items
ADD CONSTRAINT fk_Order_items_Orders
FOREIGN KEY (order_id) REFERENCES shopflow.Orders(order_id);

-- Products (PK) - (FK) Order_items
ALTER TABLE shopflow.Order_items
ADD CONSTRAINT fk_Order_items_Products
FOREIGN KEY (product_id) REFERENCES shopflow.Products(product_id);

-- Warehouses (PK) - (FK) Stocking
ALTER TABLE shopflow.Stocking
ADD CONSTRAINT fk_Stocking_Warehouses
FOREIGN KEY (warehouse_id) REFERENCES shopflow.Warehouses(warehouse_id);

-- Products (PK) - (FK) Stocking
ALTER TABLE shopflow.Stocking
ADD CONSTRAINT fk_Stocking_Products
FOREIGN KEY (product_id) REFERENCES shopflow.Products(product_id);

-- Products (PK) - (FK) Price_history
ALTER TABLE shopflow.Price_history
ADD CONSTRAINT fk_Price_history_Products
FOREIGN KEY (product_id) REFERENCES shopflow.Products(product_id);

-- Categories (PK) - (FK) Products
ALTER TABLE shopflow.Products
ADD CONSTRAINT fk_Products_Categories
FOREIGN KEY (category_id) REFERENCES shopflow.Categories(category_id);

-- Payment_methods (PK) - (FK) Payment_attempts
ALTER TABLE shopflow.Payment_attempts
ADD CONSTRAINT fk_Payment_attempts_Payment_methods
FOREIGN KEY (payment_method_id) REFERENCES shopflow.Payment_methods(payment_method_id);

-- Orders (PK) - (FK) Payment_attempts
ALTER TABLE shopflow.Payment_attempts
ADD CONSTRAINT fk_Payment_attempts_Orders
FOREIGN KEY (order_id) REFERENCES shopflow.Orders(order_id);

-- Payment_results (PK) - (FK) Payment_attempts
ALTER TABLE shopflow.Payment_attempts
ADD CONSTRAINT fk_Payment_attempts_Payment_results
FOREIGN KEY (payment_result_id) REFERENCES shopflow.Payment_results(payment_result_id);

-- Shipment_status (PK) - (FK) Shipment_status_history
ALTER TABLE shopflow.Shipment_status_history
ADD CONSTRAINT fk_Shipment_status_history_Shipment_status
FOREIGN KEY (shipment_status_id) REFERENCES shopflow.Shipment_status(shipment_status_id);

-- Shipments (PK) - (FK) Shipment_status_history
ALTER TABLE shopflow.Shipment_status_history
ADD CONSTRAINT fk_Shipment_status_history_Shipments
FOREIGN KEY (shipment_id) REFERENCES shopflow.Shipments(shipment_id);

-- Orders (PK) - (FK) Shipments
ALTER TABLE shopflow.Shipments
ADD CONSTRAINT fk_Shipments_Orders
FOREIGN KEY (order_id) REFERENCES shopflow.Orders(order_id);



COMMIT;

BEGIN;

-- CUSTOMERS 

ALTER TABLE shopflow.Customers
ADD CONSTRAINT uq_email
UNIQUE (email);

ALTER TABLE shopflow.Customers
ADD CONSTRAINT uq_tel_num
UNIQUE (tel_num);

-- ORDERS
ALTER TABLE shopflow.Orders
ADD CONSTRAINT ch_positive_total_amount
CHECK (total_amount >= 0);

-- ORDER_STATUS
ALTER TABLE shopflow.Order_status
ADD CONSTRAINT uq_status_name
UNIQUE (status_name);


-- ORDER_ITEMS
ALTER TABLE shopflow.Order_items
ADD CONSTRAINT ch_positive_quantity
CHECK (quantity > 0);

ALTER TABLE shopflow.Order_items
ADD CONSTRAINT ch_non_negative_unit_price
CHECK (unit_price >= 0);

ALTER TABLE shopflow.Order_items
ADD CONSTRAINT ch_non_negative_total_amount
CHECK (total_amount >= 0);

-- ORDER_STATUS_HISTORY
ALTER TABLE shopflow.Order_status_history
ADD CONSTRAINT timestamp_validation
CHECK (status_to > status_from);

-- Payment_attempts
ALTER TABLE shopflow.Payment_attempts
ADD CONSTRAINT ch_non_negative_amount
CHECK (amount >= 0);

-- PRICE_HISTORY
ALTER TABLE shopflow.Price_history
ADD CONSTRAINT ch_positive_amount
CHECK (amount >= 0);

ALTER TABLE shopflow.Price_history
ADD CONSTRAINT timestamp_validation
CHECK (valid_to > valid_from);

-- STOCKING
ALTER TABLE shopflow.Stocking
ADD CONSTRAINT ch_non_negative_quantity
CHECK (quantity >= 0);

-- SHIPMENT_STATUS_HISTORY
ALTER TABLE shopflow.Shipment_status_history
ADD CONSTRAINT timestamp_validation
CHECK (status_to > status_from);

-- SHIPMENT_STATUS
ALTER TABLE shopflow.Shipment_status
ADD CONSTRAINT uq_shipment_status_name
UNIQUE (shipment_status_name);

-- SHIPMENT_METHODS
ALTER TABLE shopflow.Shipment_methods
ADD CONSTRAINT uq_shipment_method_name
UNIQUE (shipment_method_name);

-- PAYMENT_RESULTS
ALTER TABLE shopflow.Payment_results
ADD CONSTRAINT uq_payment_results_name
UNIQUE (payment_result_name);

-- PAYMENT_RESULTS
ALTER TABLE shopflow.Payment_methods
ADD CONSTRAINT uq_payment_method_name
UNIQUE (payment_method_name);

-- CATEGORIES
ALTER TABLE shopflow.Categories
ADD CONSTRAINT uq_category_name
UNIQUE (category_name);

-- DISCOUNT_CODES
ALTER TABLE shopflow.Discount_codes
ADD CONSTRAINT ch_percent
CHECK (percent_discount > 0 AND percent_discount <= 100);

ALTER TABLE shopflow.Discount_codes
ADD CONSTRAINT uq_discount_code
UNIQUE (code);

ALTER TABLE shopflow.Discount_codes
ADD CONSTRAINT timestamp_validation
CHECK (valid_to > valid_from);

-- PRODUCTS
ALTER TABLE shopflow.Products
ADD CONSTRAINT uq_SKU
UNIQUE(SKU);

ALTER TABLE shopflow.Products
ADD CONSTRAINT ch_non_negative_grams
CHECK (weight_in_grams >= 0);

ALTER TABLE shopflow.Products
ADD CONSTRAINT ch_non_negative_product_cost
CHECK (product_cost >= 0);


COMMIT;