CREATE DATABASE pharmacy_db;
USE pharmacy_db;

-- User Role Table
CREATE TABLE user_role_table (
    role_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(250) NOT NULL
);

-- Medicine Brand Table
CREATE TABLE medicine_brand_table (
    brand_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(250) NOT NULL
);

-- Measurement Unit
CREATE TABLE measurement_unit_table (
    measurement_unit_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    unit_name VARCHAR(100) NOT NULL,
    unit_symbol VARCHAR(10) NOT NULL
);

-- Medicine Type
CREATE TABLE medicine_type_table (
    medicine_type_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    medicine_type VARCHAR(100) NOT NULL
);

-- Customer Type
CREATE TABLE customer_type_table (
    customer_type_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_type VARCHAR(100) NOT NULL,
    discount_percentage DECIMAL(10,2) NOT NULL
);

-- User Table
CREATE TABLE user_table(
    user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(250) NOT NULL,
    hash_password VARCHAR(250) NOT NULL,
    contact_number VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deactivated_at TIMESTAMP NULL
);
ALTER TABLE user_table ADD CONSTRAINT fk_user_role FOREIGN KEY(role_id) REFERENCES user_role_table(role_id);

-- Medicine Table
CREATE TABLE medicine_table(
	medicine_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    medicine_type_id INT NOT NULL, -- FK
    medicine_brand_id INT NOT NULL, -- FK
    measurement_unit_id INT NOT NULL, -- FK
    measurement_value DECIMAL(10,2) NOT NULL,
    `name` VARCHAR(250) NOT NULL
);
ALTER TABLE medicine_table ADD CONSTRAINT fk_medicine_table_medicine_type_id FOREIGN KEY(medicine_type_id) REFERENCES medicine_type_table(medicine_type_id);
ALTER TABLE medicine_table ADD CONSTRAINT fk_medicine_table_medicine_brand_id FOREIGN KEY(medicine_brand_id) REFERENCES medicine_brand_table(brand_id);
ALTER TABLE medicine_table ADD CONSTRAINT fk_medicine_table_measurement_unit_id FOREIGN KEY(measurement_unit_id) REFERENCES measurement_unit_table(measurement_unit_id);

-- Supplier Table
CREATE TABLE supplier_table (
    supplier_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(250) NOT NULL,
    address VARCHAR(250) NOT NULL,
    contact_number VARCHAR(20) NOT NULL,
    email VARCHAR(250) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

-- Delivery Table
CREATE TABLE delivery_table (
    delivery_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    receiver_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    received_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE delivery_table ADD CONSTRAINT fk_delivery_supplier FOREIGN KEY(supplier_id) REFERENCES supplier_table(supplier_id);
ALTER TABLE delivery_table ADD CONSTRAINT fk_delivery_receiver FOREIGN KEY(receiver_id) REFERENCES user_table(user_id);

-- Delivery Detail
CREATE TABLE delivery_detail_table (
	delivery_detail_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    delivery_id INT NOT NULL, -- FK
    medicine_id INT NOT NULL, -- FK
    order_detail_id INT NOT NULL, -- FK
    received_quantity INT NOT NULL DEFAULT 0,
    batch_number VARCHAR(100) NOT NULL, 
    expiry_date TIMESTAMP NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);
ALTER TABLE delivery_detail_table ADD CONSTRAINT fk_delivery_detail_delivery_id FOREIGN KEY(delivery_id) REFERENCES delivery_table(delivery_id);

-- Order Table
CREATE TABLE order_table (
    order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    creator_id INT NOT NULL,
    supplier_id INT NOT NULL,
    fulfillment_status VARCHAR(30) NOT NULL,
    order_number VARCHAR(200) UNIQUE NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    requested_at TIMESTAMP NULL,
    approved_at TIMESTAMP NULL,
    arrived_at TIMESTAMP NULL,
    completed_at TIMESTAMP NULL,
    cancelled_at TIMESTAMP NULL,
    returned_at TIMESTAMP NULL
);
ALTER TABLE order_table ADD CONSTRAINT fk_order_creator FOREIGN KEY(creator_id) REFERENCES user_table(user_id);
ALTER TABLE order_table ADD CONSTRAINT fk_order_supplier FOREIGN KEY(supplier_id) REFERENCES supplier_table(supplier_id);

-- Order Details
CREATE TABLE order_detail_table (
	order_detail_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT NOT NULL, -- Fk
    request_quantity INT NOT NULL
);
ALTER TABLE order_detail_table ADD CONSTRAINT fk_order_detail_medicine_id FOREIGN KEY(medicine_id) REFERENCES medicine_table(medicine_id);

-- Medicine Stock
CREATE TABLE medicine_stock_table(
	medicine_stock_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    delivery_detail_id INT NOT NULL, -- FK
    current_stock_quantity INT NOT NULL DEFAULT 0
);
ALTER TABLE medicine_stock_table ADD CONSTRAINT fk_medicine_stock_delivery_detail_id FOREIGN KEY(delivery_detail_id) REFERENCES delivery_detail_table(delivery_detail_id);

-- Sales
CREATE TABLE sales_table(
	sales_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_type_id INT NOT NULL, -- FK
    payment_method VARCHAR(100) NOT NULL, 
    total_amount DECIMAL(10,2) NOT NULL, 
    discounted_amount DECIMAL(10,2) NOT NULL,
    is_prescribed TINYINT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);
ALTER TABLE sales_table ADD CONSTRAINT fk_sales_customer_type_id FOREIGN KEY(customer_type_id) REFERENCES customer_type_table(customer_type_id);

-- Sales Details
CREATE TABLE sales_details_table(
	sales_details_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    sales_id INT NOT NULL, -- FK
    medicine_stock_id INT NOT NULL, -- FK
    quantity INT NOT NULL DEFAULT 0,
    sub_total_amount DECIMAL(10,2) NOT NULL
);
ALTER TABLE sales_details_table ADD CONSTRAINT fk_sales_details_sales_id FOREIGN KEY(sales_id) REFERENCES sales_table(sales_id);

-- Sales Customer Type Detail
CREATE TABLE sales_customer_type_detail_table (
	sales_customer_type_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    sales_id INT NOT NULL, -- FK
    customer_type_id INT NOT NULL, -- FK
    id_number VARCHAR(100)
);
ALTER TABLE sales_customer_type_detail_table ADD CONSTRAINT fk_sales_customer_type_detail_sales_id FOREIGN KEY(sales_id) REFERENCES sales_table(sales_id);
ALTER TABLE sales_customer_type_detail_table ADD CONSTRAINT fk_sales_customer_type_detail_customer_type_id FOREIGN KEY(customer_type_id) REFERENCES customer_type_table(customer_type_id);

-- 1. USER ROLE (5 rows)
INSERT INTO user_role_table (role_name) VALUES 
('Admin'), ('Pharmacist'), ('Inventory Staff'), ('Cashier'), ('Purchasing Officer');

-- 2. MEDICINE BRAND (5 rows)
INSERT INTO medicine_brand_table (brand_name) VALUES 
('Pfizer'), ('GSK'), ('Unilab'), ('Sanofi'), ('Bayer');

-- 3. MEASUREMENT UNIT (5 rows)
INSERT INTO measurement_unit_table (unit_name, unit_symbol) VALUES 
('Milligram', 'mg'), ('Gram', 'g'), ('Milliliter', 'ml'), ('International Unit', 'IU'), ('Microgram', 'mcg');

-- 4. MEDICINE TYPE (5 rows)
INSERT INTO medicine_type_table (medicine_type) VALUES 
('Tablet'), ('Capsule'), ('Syrup'), ('Injection'), ('Ointment');

-- 5. CUSTOMER TYPE (5 rows)
INSERT INTO customer_type_table (customer_type, discount_percentage) VALUES 
('Regular', 0.00), ('Senior Citizen', 20.00), ('PWD', 20.00), ('Employee', 10.00), ('VIP', 15.00);

-- 6. USER TABLE (5 rows)
INSERT INTO user_table (role_id, first_name, middle_name, last_name, email, hash_password, contact_number) VALUES 
(1, 'John', 'A.', 'Doe', 'john.doe@apexcare.com', 'pass123', '09171112233'),
(2, 'Jane', 'B.', 'Smith', 'jane.smith@apexcare.com', 'pass123', '09182223344'),
(3, 'Robert', 'C.', 'Johnson', 'robert.j@apexcare.com', 'pass123', '09193334455'),
(4, 'Emily', 'D.', 'Davis', 'emily.d@apexcare.com', 'pass123', '09204445566'),
(5, 'Michael', 'E.', 'Wilson', 'michael.w@apexcare.com', 'pass123', '09215556677');


-- 7. MEDICINE TABLE (5 rows)
INSERT INTO medicine_table (medicine_type_id, medicine_brand_id, measurement_unit_id, measurement_value, `name`) VALUES 
(1, 1, 1, 500.00, 'Paracetamol'),
(2, 2, 1, 250.00, 'Amoxicillin'),
(1, 3, 1, 400.00, 'Ibuprofen'),
(3, 4, 3, 120.00, 'Cetirizine Syrup'),
(4, 5, 2, 1.00, 'Vitamin C Injectable');

-- 8. SUPPLIER TABLE (5 rows)
INSERT INTO supplier_table (`name`, address, contact_number, email) VALUES 
('PharmaCorp Inc.', '123 Health Ave, Manila', '0281234567', 'sales@pharmacorp.com'),
('MedSupply Co.', '456 Wellness St, Quezon City', '0282345678', 'orders@medsupply.com'),
('Global Health Ltd.', '789 Cure Rd, Makati', '0283456789', 'info@globalhealth.com'),
('BioCare Pharma', '101 Healing Blvd, Pasig', '0284567890', 'contact@biocare.com'),
('Apex Distribution', '202 Remedy St, Taguig', '0285678901', 'supply@apexdist.com');

-- 9. ORDER TABLE (5 rows)
INSERT INTO order_table (creator_id, supplier_id, fulfillment_status, order_number) VALUES 
(1, 1, 'Completed', 'ORD-2026-001'),
(2, 2, 'Pending', 'ORD-2026-002'),
(3, 3, 'Approved', 'ORD-2026-003'),
(1, 4, 'Completed', 'ORD-2026-004'),
(2, 5, 'Arrived', 'ORD-2026-005');

-- 10. DELIVERY TABLE (5 rows)
INSERT INTO delivery_table (supplier_id, receiver_id, total_amount) VALUES 
(1, 2, 15000.00),
(2, 3, 8500.50),
(3, 2, 23000.00),
(4, 1, 12400.75),
(5, 3, 30000.00);

-- 11. SALES TABLE (5 rows)
INSERT INTO sales_table (customer_type_id, payment_method, total_amount, discounted_amount, is_prescribed) VALUES 
(1, 'Cash', 500.00, 500.00, 0),
(2, 'Credit Card', 1200.00, 960.00, 1),
(3, 'GCash', 850.00, 680.00, 1),
(4, 'Cash', 300.00, 270.00, 0),
(5, 'Debit Card', 2000.00, 1700.00, 1);

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- Disable foreign key checks for smooth bulk execution
SET FOREIGN_KEY_CHECKS = 0;

-- 1. ORDER DETAILS TABLE (2-10 items per Order ID 1-5)
INSERT INTO order_detail_table (order_detail_id, medicine_id, request_quantity) VALUES
-- Order 1 (3 items)
(NULL, 1, 50), (NULL, 3, 100), (NULL, 2, 25),
-- Order 2 (2 items)
(NULL, 4, 15), (NULL, 5, 80),
-- Order 3 (4 items)
(NULL, 2, 60), (NULL, 1, 120), (NULL, 3, 40), (NULL, 5, 30),
-- Order 4 (3 items)
(NULL, 3, 90), (NULL, 4, 10), (NULL, 1, 75),
-- Order 5 (5 items)
(NULL, 5, 150), (NULL, 2, 45), (NULL, 1, 200), (NULL, 4, 35), (NULL, 3, 85);

-- 2. DELIVERY DETAIL TABLE (2-10 items per Delivery ID 1-5)
INSERT INTO delivery_detail_table (delivery_id, medicine_id, order_detail_id, received_quantity, batch_number, expiry_date, unit_price) VALUES
-- Delivery 1 (3 items)
(1, 1, 1, 50, 'BATCH-1001', '2027-06-30 00:00:00', 12.50),
(1, 3, 2, 100, 'BATCH-1002', '2027-08-15 00:00:00', 45.00),
(1, 2, 3, 25, 'BATCH-1003', '2026-12-01 00:00:00', 8.75),
-- Delivery 2 (2 items)
(2, 4, 4, 15, 'BATCH-2001', '2028-01-20 00:00:00', 120.00),
(2, 5, 5, 80, 'BATCH-2002', '2027-11-10 00:00:00', 250.00),
-- Delivery 3 (4 items)
(3, 2, 6, 60, 'BATCH-3001', '2027-04-18 00:00:00', 9.00),
(3, 1, 7, 120, 'BATCH-3002', '2027-09-05 00:00:00', 12.00),
(3, 3, 8, 40, 'BATCH-3003', '2028-03-30 00:00:00', 44.50),
(3, 5, 9, 30, 'BATCH-3004', '2027-05-22 00:00:00', 245.00),
-- Delivery 4 (2 items)
(4, 3, 10, 90, 'BATCH-4001', '2027-10-12 00:00:00', 46.00),
(4, 4, 11, 10, 'BATCH-4002', '2028-06-18 00:00:00', 115.00),
-- Delivery 5 (3 items)
(5, 5, 12, 150, 'BATCH-5001', '2027-12-31 00:00:00', 255.00),
(5, 2, 13, 45, 'BATCH-5002', '2027-07-14 00:00:00', 8.50),
(5, 1, 14, 200, 'BATCH-5003', '2028-02-28 00:00:00', 11.80);

-- 3. MEDICINE STOCK TABLE (Linked directly to each delivery_detail_id above)
INSERT INTO medicine_stock_table (delivery_detail_id, current_stock_quantity) VALUES
(1, 45), (2, 95), (3, 20), (4, 12), (5, 75),
(6, 55), (7, 110), (8, 38), (9, 28), (10, 85),
(11, 8), (12, 140), (13, 40), (14, 190);

-- 4. SALES DETAILS TABLE (2-10 items per Sales ID 1-5)
INSERT INTO sales_details_table (sales_id, medicine_stock_id, quantity, sub_total_amount) VALUES
-- Sale 1 (2 items)
(1, 1, 2, 25.00), (1, 3, 1, 8.75),
-- Sale 2 (3 items)
(2, 2, 5, 225.00), (2, 4, 1, 120.00), (2, 7, 10, 120.00),
-- Sale 3 (4 items)
(3, 5, 2, 500.00), (3, 6, 3, 27.00), (3, 8, 1, 44.50), (3, 10, 2, 92.00),
-- Sale 4 (2 items)
(4, 11, 1, 115.00), (4, 13, 4, 34.00),
-- Sale 5 (3 items)
(5, 12, 1, 255.00), (5, 14, 5, 59.00), (5, 9, 2, 490.00);

-- 5. SALES CUSTOMER TYPE DETAIL TABLE (2-10 details per Sales ID 1-5)
INSERT INTO sales_customer_type_detail_table (sales_id, customer_type_id, id_number) VALUES
-- Sale 1 (2 entries)
(1, 1, 'ID-908213'), (1, 4, 'EMP-1029'),
-- Sale 2 (3 entries)
(2, 2, 'SC-441290'), (2, 2, 'SC-881230'), (2, 5, 'VIP-0012'),
-- Sale 3 (2 entries)
(3, 3, 'PWD-110293'), (3, 3, 'PWD-773821'),
-- Sale 4 (3 entries)
(4, 1, 'ID-554109'), (4, 4, 'EMP-4481'), (4, 1, 'ID-663920'),
-- Sale 5 (2 entries)
(5, 5, 'VIP-0099'), (5, 2, 'SC-339102');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1; 

-- Run procedure and cleanup
CALL PopulateChildTables();
DROP PROCEDURE IF EXISTS PopulateChildTables;


