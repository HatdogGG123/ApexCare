DROP DATABASE pharmacy_db;

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
    role_id INT NOT NULL, -- FK
    user_number VARCHAR(100) NOT NULL,
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
ALTER TABLE user_table ADD INDEX user_number (user_number);

-- Medicine Table
CREATE TABLE medicine_table(
	medicine_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    medicine_type_id INT NOT NULL, -- FK
    medicine_brand_id INT NOT NULL, -- FK
    measurement_unit_id INT NOT NULL, -- FK
    measurement_value DECIMAL(10,2) NOT NULL,
    selling_price DECIMAL(10,2) NOT NULL,
    name VARCHAR(250) NOT NULL
);
ALTER TABLE medicine_table ADD CONSTRAINT fk_medicine_table_medicine_type_id FOREIGN KEY(medicine_type_id) REFERENCES medicine_type_table(medicine_type_id);
ALTER TABLE medicine_table ADD CONSTRAINT fk_medicine_table_medicine_brand_id FOREIGN KEY(medicine_brand_id) REFERENCES medicine_brand_table(brand_id);
ALTER TABLE medicine_table ADD CONSTRAINT fk_medicine_table_measurement_unit_id FOREIGN KEY(measurement_unit_id) REFERENCES measurement_unit_table(measurement_unit_id);
ALTER TABLE medicine_table ADD INDEX name (name);

-- Supplier Table
CREATE TABLE supplier_table (
    supplier_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    supplier_number VARCHAR(100) NOT NULL,
    name VARCHAR(250) NOT NULL,
    address VARCHAR(250) NOT NULL,
    contact_number VARCHAR(20) NOT NULL,
    email VARCHAR(250) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);
ALTER TABLE supplier_table ADD INDEX name (name);
ALTER TABLE supplier_table ADD INDEX supplier_number (supplier_number);

-- Delivery Table
CREATE TABLE delivery_table (
    delivery_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL, -- FK
    receiver_id INT NOT NULL, -- FK
    delivery_number VARCHAR(100) NOT NULL,
    total_amount DECIMAL(10,2) NULL,
    received_date TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE delivery_table ADD CONSTRAINT fk_delivery_supplier FOREIGN KEY(supplier_id) REFERENCES supplier_table(supplier_id);
ALTER TABLE delivery_table ADD CONSTRAINT fk_delivery_receiver FOREIGN KEY(receiver_id) REFERENCES user_table(user_id);
ALTER TABLE delivery_table ADD INDEX delivery_number (delivery_number);

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
ALTER TABLE order_table ADD INDEX order_number_index (order_number);

-- Order Details
CREATE TABLE order_detail_table (
	order_detail_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL, -- FK
    medicine_id INT NOT NULL, -- Fk
    request_quantity INT NOT NULL
);
ALTER TABLE order_detail_table ADD CONSTRAINT fk_order_id FOREIGN KEY(order_id) REFERENCES order_table(order_id);
ALTER TABLE order_detail_table ADD CONSTRAINT fk_order_detail_medicine_id FOREIGN KEY(medicine_id) REFERENCES medicine_table(medicine_id);
ALTER TABLE order_detail_table ADD delivery_detail_id INT NOT NULL;
ALTER TABLE order_detail_table ADD received_quantity INT NOT NULL DEFAULT 0;
ALTER TABLE order_detail_table ADD CONSTRAINT fk_order_detail_delivery_detail_id FOREIGN KEY(delivery_detail_id) REFERENCES delivery_detail_table(delivery_detail_id);

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
    cashier_id INT NOT NULL, -- FK
    sales_number VARCHAR(100) NOT NULL, 
    payment_method VARCHAR(100) NOT NULL, 
    total_amount DECIMAL(10,2) NOT NULL, 
    discounted_amount DECIMAL(10,2) NOT NULL,
    is_prescribed TINYINT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);
ALTER TABLE sales_table ADD CONSTRAINT fk_sales_customer_type_id FOREIGN KEY(customer_type_id) REFERENCES customer_type_table(customer_type_id);
ALTER TABLE sales_table ADD CONSTRAINT fk_sales_cashier_id FOREIGN KEY(cashier_id) REFERENCES user_table(user_id);
ALTER TABLE sales_table ADD INDEX sales_number (sales_number);

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

-- =========================================================
-- Pharmacy System - Hardcoded Seed Data (INSERT statements)
-- Order respects foreign key dependencies.
-- =========================================================

-- ---------------------------------------------------------
-- 1. user_role_table (3 rows)
-- ---------------------------------------------------------
INSERT INTO user_role_table (role_name) VALUES
('Admin'),
('Cashier'),
('Inventory Manager');

-- ---------------------------------------------------------
-- 2. medicine_brand_table (15 rows)
-- ---------------------------------------------------------
INSERT INTO medicine_brand_table (brand_name) VALUES
('Biogesic'),
('Neozep'),
('Bioflu'),
('Alaxan'),
('Medicol'),
('Tempra'),
('Advil'),
('Solmux'),
('Diatabs'),
('Kremil-S'),
('Buscopan'),
('Ceelin'),
('Enervon'),
('Robitussin'),
('Decolgen');

-- ---------------------------------------------------------
-- 3. measurement_unit_table (15 rows)
-- ---------------------------------------------------------
INSERT INTO measurement_unit_table (unit_name, unit_symbol) VALUES
('Milligram', 'mg'),
('Gram', 'g'),
('Milliliter', 'ml'),
('Liter', 'L'),
('Tablet', 'tab'),
('Capsule', 'cap'),
('Bottle', 'btl'),
('Box', 'bx'),
('Piece', 'pc'),
('Sachet', 'sch'),
('Vial', 'vl'),
('Ampule', 'amp'),
('Strip', 'strp'),
('Kilogram', 'kg'),
('Pack', 'pck');

-- ---------------------------------------------------------
-- 4. medicine_type_table (15 rows)
-- ---------------------------------------------------------
INSERT INTO medicine_type_table (medicine_type) VALUES
('Analgesic'),
('Antibiotic'),
('Antihistamine'),
('Antacid'),
('Antiseptic'),
('Antipyretic'),
('Antitussive'),
('Vitamin'),
('Supplement'),
('Antidiarrheal'),
('Antifungal'),
('Antiviral'),
('Decongestant'),
('Laxative'),
('Anti-inflammatory');

-- ---------------------------------------------------------
-- 5. customer_type_table (15 rows)
-- ---------------------------------------------------------
INSERT INTO customer_type_table (customer_type, discount_percentage) VALUES
('Regular', 0.00),
('Senior Citizen', 20.00),
('PWD', 20.00),
('Student', 5.00),
('Employee', 10.00),
('Member', 8.00),
('Wholesale', 15.00),
('Government', 12.00),
('Corporate', 10.00),
('VIP', 25.00),
('Walk-in', 0.00),
('Online', 3.00),
('Bulk Buyer', 18.00),
('Referral', 5.00),
('Loyalty', 7.00);

-- ---------------------------------------------------------
-- 6. supplier_table (15 rows)
-- ---------------------------------------------------------
INSERT INTO supplier_table (supplier_number, name, address, contact_number, email) VALUES
('SUP-0001', 'MedSource Philippines Inc.', '123 Rizal St, Manila', '09171234501', 'contact@medsource.ph'),
('SUP-0002', 'Metro Drug Distributors', '45 EDSA, Quezon City', '09171234502', 'sales@metrodrug.ph'),
('SUP-0003', 'HealthLink Supply Co.', '78 Aguinaldo Hwy, Dasmarinas', '09171234503', 'info@healthlink.ph'),
('SUP-0004', 'PharmaTrade Corp.', '12 Taft Ave, Manila', '09171234504', 'orders@pharmatrade.ph'),
('SUP-0005', 'United Pharma Supplies', '89 Ortigas Ave, Pasig', '09171234505', 'support@unitedpharma.ph'),
('SUP-0006', 'Zuellig Pharma', '5 McKinley Rd, Taguig', '09171234506', 'contact@zuelligpharma.ph'),
('SUP-0007', 'Metro Wellness Traders', '33 Marcos Hwy, Antipolo', '09171234507', 'sales@metrowellness.ph'),
('SUP-0008', 'CarePlus Distribution', '66 Commonwealth Ave, QC', '09171234508', 'info@careplus.ph'),
('SUP-0009', 'National Pharma Corp', '17 Session Rd, Baguio', '09171234509', 'orders@nationalpharma.ph'),
('SUP-0010', 'VitaHealth Supply Chain', '21 Osmena Blvd, Cebu City', '09171234510', 'contact@vitahealth.ph'),
('SUP-0011', 'Prime Medical Traders', '9 Magsaysay Ave, Davao', '09171234511', 'sales@primemedical.ph'),
('SUP-0012', 'BioCare Distributors', '54 Del Monte Ave, QC', '09171234512', 'info@biocare.ph'),
('SUP-0013', 'FastMed Logistics', '3 Katipunan Ave, QC', '09171234513', 'support@fastmed.ph'),
('SUP-0014', 'PhilHealth Supplies Inc.', '28 Roxas Blvd, Manila', '09171234514', 'contact@philhealthsupplies.ph'),
('SUP-0015', 'GreenLeaf Pharma Trading', '41 Aurora Blvd, QC', '09171234515', 'sales@greenleafpharma.ph');

-- ---------------------------------------------------------
-- 7. user_table (20 rows)
-- ---------------------------------------------------------
INSERT INTO user_table (role_id, user_number, first_name, middle_name, last_name, email, hash_password, contact_number) VALUES
(1, 'USR-0001', 'Juan',      'Santos',   'Dela Cruz',  'juan.delacruz@pharmacy.ph',   '$2y$10$examplehash0000000001', '09201234501'),
(2, 'USR-0002', 'Maria',     'Reyes',    'Santos',     'maria.santos@pharmacy.ph',    '$2y$10$examplehash0000000002', '09201234502'),
(3, 'USR-0003', 'Jose',      'Garcia',   'Ramos',      'jose.ramos@pharmacy.ph',      '$2y$10$examplehash0000000003', '09201234503'),
(1, 'USR-0004', 'Ana',       'Torres',   'Villanueva', 'ana.villanueva@pharmacy.ph',  '$2y$10$examplehash0000000004', '09201234504'),
(2, 'USR-0005', 'Pedro',     'Lopez',    'Bautista',   'pedro.bautista@pharmacy.ph',  '$2y$10$examplehash0000000005', '09201234505'),
(3, 'USR-0006', 'Carmen',    'Flores',   'Aquino',     'carmen.aquino@pharmacy.ph',   '$2y$10$examplehash0000000006', '09201234506'),
(1, 'USR-0007', 'Ramon',     'Cruz',     'Mendoza',    'ramon.mendoza@pharmacy.ph',   '$2y$10$examplehash0000000007', '09201234507'),
(2, 'USR-0008', 'Luz',       'Pascual',  'Fernandez',  'luz.fernandez@pharmacy.ph',   '$2y$10$examplehash0000000008', '09201234508'),
(3, 'USR-0009', 'Antonio',   'Navarro',  'Castillo',   'antonio.castillo@pharmacy.ph','$2y$10$examplehash0000000009', '09201234509'),
(1, 'USR-0010', 'Elena',     'Domingo',  'Marquez',    'elena.marquez@pharmacy.ph',   '$2y$10$examplehash0000000010', '09201234510'),
(2, 'USR-0011', 'Ricardo',   'Salazar',  'Ocampo',     'ricardo.ocampo@pharmacy.ph',  '$2y$10$examplehash0000000011', '09201234511'),
(3, 'USR-0012', 'Teresa',    'Gonzales', 'Rivera',     'teresa.rivera@pharmacy.ph',   '$2y$10$examplehash0000000012', '09201234512'),
(1, 'USR-0013', 'Manuel',    'Ibarra',   'Soriano',    'manuel.soriano@pharmacy.ph',  '$2y$10$examplehash0000000013', '09201234513'),
(2, 'USR-0014', 'Rosario',   'Valdez',   'Pineda',     'rosario.pineda@pharmacy.ph',  '$2y$10$examplehash0000000014', '09201234514'),
(3, 'USR-0015', 'Fernando',  'Cabrera',  'Espino',     'fernando.espino@pharmacy.ph', '$2y$10$examplehash0000000015', '09201234515'),
(1, 'USR-0016', 'Isabel',    'Herrera',  'Tolentino',  'isabel.tolentino@pharmacy.ph','$2y$10$examplehash0000000016', '09201234516'),
(2, 'USR-0017', 'Vicente',   'Ramirez',  'Guevarra',   'vicente.guevarra@pharmacy.ph','$2y$10$examplehash0000000017', '09201234517'),
(3, 'USR-0018', 'Corazon',   'Mercado',  'Padilla',    'corazon.padilla@pharmacy.ph', '$2y$10$examplehash0000000018', '09201234518'),
(1, 'USR-0019', 'Emilio',    'Bermudez', 'Roxas',      'emilio.roxas@pharmacy.ph',    '$2y$10$examplehash0000000019', '09201234519'),
(2, 'USR-0020', 'Victoria',  'Del Rosario', 'Aguilar', 'victoria.aguilar@pharmacy.ph','$2y$10$examplehash0000000020', '09201234520');

-- ---------------------------------------------------------
-- 8. medicine_table (20 rows)
-- ---------------------------------------------------------
INSERT INTO medicine_table (medicine_type_id, medicine_brand_id, measurement_unit_id, measurement_value, selling_price, name) VALUES
(1,  1,  5,  500.00, 6.50,  'Biogesic 500mg Tablet'),
(7,  2,  10, 10.00,  8.00,  'Neozep Sachet'),
(6,  3,  5,  500.00, 7.25,  'Bioflu Tablet'),
(1,  4,  6,  200.00, 9.50,  'Alaxan FR Capsule'),
(1,  5,  5,  200.00, 5.75,  'Medicol Advance Tablet'),
(6,  6,  3,  100.00, 45.00, 'Tempra Forte Syrup 100ml'),
(1,  7,  5,  200.00, 12.00, 'Advil Tablet'),
(2,  8,  5,  500.00, 10.50, 'Solmux Tablet'),
(10, 9,  5,  2.00,   6.00,  'Diatabs Tablet'),
(4,  10, 5,  500.00, 7.00,  'Kremil-S Tablet'),
(4,  11, 6,  10.00,  15.00, 'Buscopan Capsule'),
(8,  12, 3,  120.00, 65.00, 'Ceelin Plus Syrup 120ml'),
(8,  13, 5,  500.00, 8.75,  'Enervon Tablet'),
(7,  14, 3,  120.00, 55.00, 'Robitussin Syrup 120ml'),
(13, 15, 5,  10.00,  6.25,  'Decolgen Forte Tablet'),
(3,  1,  5,  10.00,  9.00,  'Biogesic Allerkid Syrup'),
(2,  6,  6,  500.00, 18.00, 'Tempra Antibiotic Capsule'),
(5,  9,  7,  60.00,  85.00, 'Diatabs Antiseptic Solution 60ml'),
(9,  13, 8,  30.00,  120.00,'Enervon Vitamin Box'),
(11, 4,  6,  150.00, 22.00, 'Alaxan Antifungal Capsule');

-- ---------------------------------------------------------
-- 9. order_table (20 rows)
-- ---------------------------------------------------------
INSERT INTO order_table (creator_id, supplier_id, fulfillment_status, order_number, requested_at, approved_at, arrived_at, completed_at, cancelled_at, returned_at) VALUES
(1,  1,  'Completed', 'ORD-0001', '2026-01-05 09:00:00', '2026-01-05 10:00:00', '2026-01-08 13:00:00', '2026-01-08 14:00:00', NULL, NULL),
(2,  2,  'Completed', 'ORD-0002', '2026-01-06 09:00:00', '2026-01-06 10:30:00', '2026-01-09 11:00:00', '2026-01-09 12:00:00', NULL, NULL),
(3,  3,  'Pending',   'ORD-0003', '2026-01-07 09:00:00', NULL, NULL, NULL, NULL, NULL),
(4,  4,  'Completed', 'ORD-0004', '2026-01-08 09:00:00', '2026-01-08 09:45:00', '2026-01-10 15:00:00', '2026-01-10 16:00:00', NULL, NULL),
(5,  5,  'Cancelled', 'ORD-0005', '2026-01-09 09:00:00', NULL, NULL, NULL, '2026-01-09 12:00:00', NULL),
(6,  6,  'Completed', 'ORD-0006', '2026-01-10 09:00:00', '2026-01-10 10:00:00', '2026-01-12 09:00:00', '2026-01-12 10:00:00', NULL, NULL),
(7,  7,  'Approved',  'ORD-0007', '2026-01-11 09:00:00', '2026-01-11 11:00:00', NULL, NULL, NULL, NULL),
(8,  8,  'Completed', 'ORD-0008', '2026-01-12 09:00:00', '2026-01-12 10:00:00', '2026-01-14 13:00:00', '2026-01-14 14:00:00', NULL, NULL),
(9,  9,  'Returned',  'ORD-0009', '2026-01-13 09:00:00', '2026-01-13 09:30:00', '2026-01-15 09:00:00', NULL, NULL, '2026-01-16 10:00:00'),
(10, 10, 'Completed', 'ORD-0010', '2026-01-14 09:00:00', '2026-01-14 09:30:00', '2026-01-16 09:00:00', '2026-01-16 10:00:00', NULL, NULL),
(11, 11, 'Pending',   'ORD-0011', '2026-01-15 09:00:00', NULL, NULL, NULL, NULL, NULL),
(12, 12, 'Completed', 'ORD-0012', '2026-01-16 09:00:00', '2026-01-16 10:00:00', '2026-01-18 09:00:00', '2026-01-18 10:00:00', NULL, NULL),
(13, 13, 'Approved',  'ORD-0013', '2026-01-17 09:00:00', '2026-01-17 10:00:00', NULL, NULL, NULL, NULL),
(14, 14, 'Completed', 'ORD-0014', '2026-01-18 09:00:00', '2026-01-18 09:45:00', '2026-01-20 09:00:00', '2026-01-20 10:00:00', NULL, NULL),
(15, 15, 'Cancelled', 'ORD-0015', '2026-01-19 09:00:00', NULL, NULL, NULL, '2026-01-19 15:00:00', NULL),
(16, 1,  'Completed', 'ORD-0016', '2026-01-20 09:00:00', '2026-01-20 09:30:00', '2026-01-22 09:00:00', '2026-01-22 10:00:00', NULL, NULL),
(17, 2,  'Pending',   'ORD-0017', '2026-01-21 09:00:00', NULL, NULL, NULL, NULL, NULL),
(18, 3,  'Completed', 'ORD-0018', '2026-01-22 09:00:00', '2026-01-22 10:00:00', '2026-01-24 09:00:00', '2026-01-24 10:00:00', NULL, NULL),
(19, 4,  'Approved',  'ORD-0019', '2026-01-23 09:00:00', '2026-01-23 09:30:00', NULL, NULL, NULL, NULL),
(20, 5,  'Completed', 'ORD-0020', '2026-01-24 09:00:00', '2026-01-24 09:45:00', '2026-01-26 09:00:00', '2026-01-26 10:00:00', NULL, NULL);

-- ---------------------------------------------------------
-- 10. delivery_table (20 rows)
-- ---------------------------------------------------------
INSERT INTO delivery_table (supplier_id, receiver_id, delivery_number, total_amount, received_date) VALUES
(1,  1,  'DLV-0001', 5200.00, '2026-01-08 13:30:00'),
(2,  2,  'DLV-0002', 3100.75, '2026-01-09 11:15:00'),
(3,  3,  'DLV-0003', NULL,    NULL),
(4,  4,  'DLV-0004', 8720.50, '2026-01-10 15:20:00'),
(5,  5,  'DLV-0005', NULL,    NULL),
(6,  6,  'DLV-0006', 2450.00, '2026-01-12 09:30:00'),
(7,  7,  'DLV-0007', 6100.00, '2026-01-13 10:00:00'),
(8,  8,  'DLV-0008', 990.25,  '2026-01-14 13:15:00'),
(9,  9,  'DLV-0009', 4300.00, '2026-01-15 09:20:00'),
(10, 10, 'DLV-0010', 7650.00, '2026-01-16 09:10:00'),
(11, 11, 'DLV-0011', NULL,    NULL),
(12, 12, 'DLV-0012', 3200.00, '2026-01-18 09:40:00'),
(13, 13, 'DLV-0013', 5100.50, '2026-01-19 10:05:00'),
(14, 14, 'DLV-0014', 2999.99, '2026-01-20 09:15:00'),
(15, 15, 'DLV-0015', NULL,    NULL),
(1,  16, 'DLV-0016', 6400.00, '2026-01-22 09:25:00'),
(2,  17, 'DLV-0017', NULL,    NULL),
(3,  18, 'DLV-0018', 4750.00, '2026-01-24 09:35:00'),
(4,  19, 'DLV-0019', 3300.00, '2026-01-25 09:50:00'),
(5,  20, 'DLV-0020', 5900.00, '2026-01-26 09:05:00');

-- ---------------------------------------------------------
-- 11. delivery_detail_table (10 rows)
-- ---------------------------------------------------------
INSERT INTO delivery_detail_table (delivery_id, medicine_id, order_detail_id, received_quantity, batch_number, expiry_date, unit_price) VALUES
(1,  1,  1,  100, 'BATCH-0001', '2027-06-01 00:00:00', 5.00),
(2,  2,  2,  200, 'BATCH-0002', '2027-07-01 00:00:00', 6.50),
(4,  3,  3,  150, 'BATCH-0003', '2027-08-01 00:00:00', 6.00),
(6,  4,  4,  80,  'BATCH-0004', '2027-05-15 00:00:00', 8.00),
(7,  5,  5,  120, 'BATCH-0005', '2027-09-01 00:00:00', 4.50),
(8,  6,  6,  60,  'BATCH-0006', '2027-04-20 00:00:00', 38.00),
(9,  7,  7,  90,  'BATCH-0007', '2027-10-01 00:00:00', 10.00),
(10, 8,  8,  200, 'BATCH-0008', '2027-11-01 00:00:00', 9.00),
(12, 9,  9,  300, 'BATCH-0009', '2027-03-10 00:00:00', 5.00),
(13, 10, 10, 250, 'BATCH-0010', '2027-12-01 00:00:00', 6.00);

-- ---------------------------------------------------------
-- 12. order_detail_table (10 rows)
-- ---------------------------------------------------------
INSERT INTO order_detail_table (order_id, medicine_id, request_quantity, received_quantity, delivery_detail_id) VALUES
(1,  1,  100, 100, 1),
(2,  2,  200, 200, 2),
(4,  3,  150, 150, 3),
(6,  4,  80,  80,  4),
(8,  5,  120, 120, 5),
(10, 6,  60,  60,  6),
(12, 7,  90,  90,  7),
(14, 8,  200, 200, 8),
(16, 9,  300, 300, 9),
(18, 10, 250, 250, 10);

-- ---------------------------------------------------------
-- 13. medicine_stock_table (10 rows)
-- ---------------------------------------------------------
INSERT INTO medicine_stock_table (delivery_detail_id, current_stock_quantity) VALUES
(1,  95),
(2,  185),
(3,  140),
(4,  75),
(5,  110),
(6,  55),
(7,  85),
(8,  190),
(9,  280),
(10, 240);

-- ---------------------------------------------------------
-- 14. sales_table (15 rows)
-- ---------------------------------------------------------
INSERT INTO sales_table (customer_type_id, cashier_id, sales_number, payment_method, total_amount, discounted_amount, is_prescribed) VALUES
(1,  3,  'SALE-0001', 'Cash',        250.00, 250.00, 0),
(2,  3,  'SALE-0002', 'Cash',        180.00, 144.00, 0),
(3,  8,  'SALE-0003', 'Card',        320.50, 256.40, 1),
(4,  8,  'SALE-0004', 'GCash',       95.75,  90.96,  0),
(1,  12, 'SALE-0005', 'Cash',        410.00, 410.00, 1),
(5,  12, 'SALE-0006', 'Card',        150.00, 135.00, 0),
(6,  17, 'SALE-0007', 'GCash',       275.25, 253.23, 0),
(2,  17, 'SALE-0008', 'Cash',        99.00,  79.20,  0),
(7,  3,  'SALE-0009', 'Card',        890.00, 756.50, 1),
(1,  8,  'SALE-0010', 'Cash',        60.00,  60.00,  0),
(10, 12, 'SALE-0011', 'GCash',       540.00, 405.00, 1),
(3,  17, 'SALE-0012', 'Cash',        220.00, 176.00, 0),
(1,  3,  'SALE-0013', 'Card',        135.50, 135.50, 0),
(8,  8,  'SALE-0014', 'Cash',        375.00, 330.00, 1),
(1,  12, 'SALE-0015', 'GCash',       48.00,  48.00,  0);

-- ---------------------------------------------------------
-- 15. sales_details_table (10 rows)
-- ---------------------------------------------------------
INSERT INTO sales_details_table (sales_id, medicine_stock_id, quantity, sub_total_amount) VALUES
(1,  1,  5,  32.50),
(2,  2,  3,  19.50),
(3,  3,  2,  15.50),
(4,  4,  1,  9.50),
(5,  5,  6,  34.50),
(6,  6,  2,  90.00),
(7,  7,  4,  48.00),
(8,  8,  1,  10.50),
(9,  9,  2,  12.00),
(10, 10, 3,  21.00);

-- ---------------------------------------------------------
-- 16. sales_customer_type_detail_table (10 rows)
-- ---------------------------------------------------------
INSERT INTO sales_customer_type_detail_table (sales_id, customer_type_id, id_number) VALUES
(1,  1,  NULL),
(2,  2,  'SC-00123'),
(3,  3,  'PWD-00456'),
(4,  4,  'STU-00789'),
(5,  1,  NULL),
(6,  5,  'EMP-00234'),
(7,  6,  'MEM-00567'),
(8,  2,  'SC-00890'),
(9,  7,  'WS-00345'),
(10, 1,  NULL);

-- ---------------------------------------------------------
-- 17. order_table (10 more rows, order_id 21-30)
-- ---------------------------------------------------------
INSERT INTO order_table (creator_id, supplier_id, fulfillment_status, order_number, requested_at, approved_at, arrived_at, completed_at, cancelled_at, returned_at) VALUES
(6,  6,  'Completed',           'ORD-0021', '2026-02-01 09:00:00', '2026-02-01 10:00:00', '2026-02-03 13:00:00', '2026-02-03 14:00:00', NULL, NULL),
(7,  7,  'Completed',           'ORD-0022', '2026-02-02 09:00:00', '2026-02-02 10:00:00', '2026-02-04 11:00:00', '2026-02-04 12:00:00', NULL, NULL),
(8,  8,  'Partially Fulfilled', 'ORD-0023', '2026-02-03 09:00:00', '2026-02-03 09:30:00', '2026-02-05 10:00:00', NULL, NULL, NULL),
(9,  9,  'Completed',           'ORD-0024', '2026-02-04 09:00:00', '2026-02-04 09:45:00', '2026-02-06 15:00:00', '2026-02-06 16:00:00', NULL, NULL),
(10, 10, 'Partially Fulfilled', 'ORD-0025', '2026-02-05 09:00:00', '2026-02-05 09:30:00', '2026-02-07 10:00:00', NULL, NULL, NULL),
(11, 11, 'Completed',           'ORD-0026', '2026-02-06 09:00:00', '2026-02-06 10:00:00', '2026-02-08 09:00:00', '2026-02-08 10:00:00', NULL, NULL),
(12, 12, 'Partially Fulfilled', 'ORD-0027', '2026-02-07 09:00:00', '2026-02-07 09:30:00', '2026-02-09 09:00:00', NULL, NULL, NULL),
(13, 13, 'Completed',           'ORD-0028', '2026-02-08 09:00:00', '2026-02-08 10:00:00', '2026-02-10 13:00:00', '2026-02-10 14:00:00', NULL, NULL),
(14, 14, 'Partially Fulfilled', 'ORD-0029', '2026-02-09 09:00:00', '2026-02-09 09:30:00', '2026-02-11 09:00:00', NULL, NULL, NULL),
(15, 15, 'Completed',           'ORD-0030', '2026-02-10 09:00:00', '2026-02-10 09:45:00', '2026-02-12 09:00:00', '2026-02-12 10:00:00', NULL, NULL);

-- ---------------------------------------------------------
-- 18. delivery_table (10 more rows, delivery_id 21-30)
-- ---------------------------------------------------------
INSERT INTO delivery_table (supplier_id, receiver_id, delivery_number, total_amount, received_date) VALUES
(6,  6,  'DLV-0021', 5300.00, '2026-02-03 13:30:00'),
(7,  7,  'DLV-0022', 4200.00, '2026-02-04 11:15:00'),
(8,  8,  'DLV-0023', 3900.00, '2026-02-05 10:20:00'),
(9,  9,  'DLV-0024', 6100.00, '2026-02-06 15:20:00'),
(10, 10, 'DLV-0025', 5000.00, '2026-02-07 10:10:00'),
(11, 11, 'DLV-0026', 4750.00, '2026-02-08 09:30:00'),
(12, 12, 'DLV-0027', 7200.00, '2026-02-09 09:15:00'),
(13, 13, 'DLV-0028', 3600.00, '2026-02-10 13:15:00'),
(14, 14, 'DLV-0029', 8900.00, '2026-02-11 09:20:00'),
(15, 15, 'DLV-0030', 6500.00, '2026-02-12 09:10:00');

-- ---------------------------------------------------------
-- 19. delivery_detail_table (20 more rows, delivery_detail_id 11-30)
-- ---------------------------------------------------------
INSERT INTO delivery_detail_table (delivery_id, medicine_id, order_detail_id, received_quantity, batch_number, expiry_date, unit_price) VALUES
(21, 1,  11, 500, 'BATCH-0011', '2027-06-01 00:00:00', 5.00),
(21, 2,  13, 300, 'BATCH-0012', '2027-07-01 00:00:00', 6.50),
(22, 3,  15, 400, 'BATCH-0013', '2027-08-01 00:00:00', 6.00),
(22, 4,  16, 200, 'BATCH-0014', '2027-05-15 00:00:00', 8.00),
(23, 5,  18, 350, 'BATCH-0015', '2027-09-01 00:00:00', 4.50),
(23, 6,  19, 150, 'BATCH-0016', '2027-04-20 00:00:00', 38.00),
(24, 7,  20, 600, 'BATCH-0017', '2027-10-01 00:00:00', 10.00),
(24, 8,  21, 250, 'BATCH-0018', '2027-11-01 00:00:00', 9.00),
(25, 9,  26, 700, 'BATCH-0019', '2027-03-10 00:00:00', 5.00),
(25, 10, 25, 300, 'BATCH-0020', '2027-12-01 00:00:00', 6.00),
(26, 11, 22, 450, 'BATCH-0021', '2028-01-01 00:00:00', 15.00),
(26, 12, 23, 200, 'BATCH-0022', '2028-02-01 00:00:00', 65.00),
(27, 13, 24, 500, 'BATCH-0023', '2028-03-01 00:00:00', 8.75),
(27, 14, 25, 220, 'BATCH-0024', '2028-04-01 00:00:00', 55.00),
(28, 15, 27, 380, 'BATCH-0025', '2028-05-01 00:00:00', 6.25),
(28, 16, 28, 260, 'BATCH-0026', '2028-06-01 00:00:00', 9.00),
(29, 17, 29, 320, 'BATCH-0027', '2028-07-01 00:00:00', 18.00),
(29, 18, 30, 150, 'BATCH-0028', '2028-08-01 00:00:00', 85.00),
(30, 19, 30, 400, 'BATCH-0029', '2028-09-01 00:00:00', 120.00),
(30, 20, 30, 210, 'BATCH-0030', '2028-10-01 00:00:00', 22.00);

-- ---------------------------------------------------------
-- 20. order_detail_table (20 more rows, order_detail_id 11-30)
-- ---------------------------------------------------------
INSERT INTO order_detail_table (order_id, medicine_id, request_quantity, received_quantity, delivery_detail_id) VALUES
(21, 1,  300, 300, 11),  -- order_detail_id 11: fully covered
(22, 1,  150, 150, 11),  -- order_detail_id 12: fully covered (combined w/ #11 = 450/500)
(22, 2,  300, 300, 12),  -- order_detail_id 13: fully covered, exact match to dd12
(23, 1,  100, 50,  11),  -- order_detail_id 14: INCOMPLETE - dd11 only had 50 left (550/500 oversubscribed)
(24, 3,  250, 250, 13),  -- order_detail_id 15: fully covered
(24, 4,  200, 200, 14),  -- order_detail_id 16: fully covered, exact match to dd14
(25, 3,  200, 150, 13),  -- order_detail_id 17: INCOMPLETE - dd13 only had 150 left (450/400 oversubscribed)
(26, 5,  350, 350, 15),  -- order_detail_id 18: fully covered, exact match to dd15
(26, 6,  150, 150, 16),  -- order_detail_id 19: fully covered, exact match to dd16
(27, 7,  650, 600, 17),  -- order_detail_id 20: INCOMPLETE - dd17 only received 600
(28, 8,  250, 250, 18),  -- order_detail_id 21: fully covered, exact match to dd18
(29, 11, 500, 450, 21),  -- order_detail_id 22: INCOMPLETE - dd21 only received 450
(29, 12, 150, 150, 22),  -- order_detail_id 23: fully covered, within dd22's 200
(30, 13, 500, 500, 23),  -- order_detail_id 24: fully covered, exact match to dd23
(30, 14, 220, 220, 24),  -- order_detail_id 25: fully covered, exact match to dd24
(21, 9,  400, 400, 19),  -- order_detail_id 26: fully covered, within dd19's 700
(25, 15, 380, 380, 25),  -- order_detail_id 27: fully covered, exact match to dd25
(27, 16, 260, 260, 26),  -- order_detail_id 28: fully covered, exact match to dd26
(29, 17, 320, 320, 27),  -- order_detail_id 29: fully covered, exact match to dd27
(30, 18, 150, 150, 28);  -- order_detail_id 30: fully covered, exact match to dd28

-- ---------------------------------------------------------
-- 21. medicine_stock_table (10 more rows, medicine_stock_id 11-20)
-- ---------------------------------------------------------
INSERT INTO medicine_stock_table (delivery_detail_id, current_stock_quantity) VALUES
(11, 0),    -- 500 received, 550 requested across 3 orders -> depleted, backorder
(13, 0),    -- 400 received, 450 requested across 2 orders -> depleted, backorder
(15, 0),    -- 350 received, 350 requested -> exact, none left
(17, 0),    -- 600 received, 650 requested -> depleted, backorder
(19, 300),  -- 700 received, 400 committed so far -> stock remaining
(21, 0),    -- 450 received, 500 requested -> depleted, backorder
(23, 0),    -- 500 received, 500 requested -> exact, none left
(25, 0),    -- 380 received, 380 requested -> exact, none left
(27, 0),    -- 320 received, 320 requested -> exact, none left
(29, 400);  -- 400 received, not yet committed to any order -> full stock available









