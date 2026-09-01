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
    `name` VARCHAR(250) NOT NULL
);
ALTER TABLE medicine_table ADD CONSTRAINT fk_medicine_table_medicine_type_id FOREIGN KEY(medicine_type_id) REFERENCES medicine_type_table(medicine_type_id);
ALTER TABLE medicine_table ADD CONSTRAINT fk_medicine_table_medicine_brand_id FOREIGN KEY(medicine_brand_id) REFERENCES medicine_brand_table(brand_id);
ALTER TABLE medicine_table ADD CONSTRAINT fk_medicine_table_measurement_unit_id FOREIGN KEY(measurement_unit_id) REFERENCES measurement_unit_table(measurement_unit_id);
ALTER TABLE medicine_table ADD INDEX `name` (`name`);

-- Supplier Table
CREATE TABLE supplier_table (
    supplier_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    supplier_number VARCHAR(100) NOT NULL,
    `name` VARCHAR(250) NOT NULL,
    address VARCHAR(250) NOT NULL,
    contact_number VARCHAR(20) NOT NULL,
    email VARCHAR(250) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);
ALTER TABLE supplier_table ADD INDEX `name` (`name`);
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
ALTER TABLE order_table ADD INDEX order_number (order_number);

-- Order Details
CREATE TABLE order_detail_table (
	order_detail_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL, -- FK
    medicine_id INT NOT NULL, -- Fk
    request_quantity INT NOT NULL
);
ALTER TABLE order_detail_table ADD CONSTRAINT fk_order_id FOREIGN KEY(order_id) REFERENCES order_table(order_id);
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
    sales_number VARCHAR(100) NOT NULL, 
    payment_method VARCHAR(100) NOT NULL, 
    total_amount DECIMAL(10,2) NOT NULL, 
    discounted_amount DECIMAL(10,2) NOT NULL,
    is_prescribed TINYINT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);
ALTER TABLE sales_table ADD CONSTRAINT fk_sales_customer_type_id FOREIGN KEY(customer_type_id) REFERENCES customer_type_table(customer_type_id);
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

-- 1. USER ROLE (5 rows)
INSERT INTO user_role_table (role_name) VALUES
('Admin'),
('Cashier'),
('Inventory Staff'),

-- 2. MEDICINE BRAND (5 rows)
INSERT INTO medicine_brand_table (brand_name) VALUES
('Unilab'),
('GSK Philippines'),
('Pfizer Inc.'),
('RiteMed'),
('Pascual Laboratories'),
('Sanofi-Aventis Philippines'),
('Novartis Healthcare'),
('United Laboratories Biotek');

-- 3. MEASUREMENT UNIT (5 rows)
INSERT INTO measurement_unit_table (unit_name, unit_symbol) VALUES
('Milligram', 'mg'),
('Milliliter', 'mL'),
('Gram', 'g'),
('Tablet', 'tab'),
('Capsule', 'cap'),
('International Unit', 'IU');

-- 4. MEDICINE TYPE (5 rows)
INSERT INTO medicine_type_table (medicine_type) VALUES
('Tablet'),
('Capsule'),
('Syrup'),
('Injection'),
('Ointment'),
('Drops'),
('Suppository');

-- 5. CUSTOMER TYPE (5 rows)
INSERT INTO customer_type_table (customer_type, discount_percentage) VALUES
('Regular', 0.00),
('Senior Citizen', 20.00),
('PWD', 20.00),
('Student', 5.00),
('Employee', 10.00);

-- 6. USER TABLE (5 rows)
INSERT INTO user_table (role_id, user_number, first_name, middle_name, last_name, email, hash_password, contact_number, created_at, deactivated_at) VALUES
(1, 'U1213', 'Renzo', 'Miguel', 'Tolentino', 'renzo.tolentino@apexcare.ph', 'pass123', '09171234567', '2025-01-15 08:30:00', NULL),
(2, 'U1001', 'Maria', 'Santos', 'Cruz', 'maria.cruz@apexcare.ph', 'pass123', '09182345678', '2025-01-20 09:00:00', NULL),
(2, 'U1002', 'Juan', 'Dela', 'Reyes', 'juan.reyes@apexcare.ph', 'pass123', '09193456789', '2025-02-01 08:45:00', NULL),
(3, 'U1003', 'Anna', 'Marie', 'Garcia', 'anna.garcia@apexcare.ph', 'pass123', '09204567890', '2025-02-10 10:00:00', NULL),
(3, 'U1004', 'Jose', 'Ramon', 'Bautista', 'jose.bautista@apexcare.ph', 'pass123', '09215678901', '2025-03-05 09:15:00', NULL),
(4, 'U1005', 'Liza', 'Mae', 'Torres', 'liza.torres@apexcare.ph', 'pass123', '09226789012', '2025-03-18 08:00:00', NULL),
(4, 'U1006', 'Mark', 'Anthony', 'Villanueva', 'mark.villanueva@apexcare.ph', 'pass123', '09237890123', '2025-04-02 09:30:00', NULL),
(2, 'U1007', 'Carmela', 'Rose', 'Mendoza', 'carmela.mendoza@apexcare.ph', 'pass123', '09248901234', '2025-04-22 08:20:00', NULL),
(5, 'U1008', 'Ricardo', 'Jr.', 'Aquino', 'ricardo.aquino@apexcare.ph', 'pass123', '09259012345', '2025-05-10 09:00:00', NULL),
(3, 'U1009', 'Grace', 'Ann', 'Fernandez', 'grace.fernandez@apexcare.ph', 'pass123', '09260123456', '2025-06-01 08:40:00', '2026-05-15 17:00:00');

-- 7. MEDICINE TABLE (5 rows)
INSERT INTO medicine_table (medicine_type_id, medicine_brand_id, measurement_unit_id, measurement_value, name) VALUES
(1, 1, 1, 500.00, 'Biogesic 500mg Tablet (Paracetamol)'),
(2, 2, 1, 500.00, 'Amoxil 500mg Capsule (Amoxicillin)'),
(1, 2, 1, 10.00, 'Virlix 10mg Tablet (Cetirizine)'),
(2, 1, 1, 2.00, 'Diatabs 2mg Capsule (Loperamide)'),
(1, 3, 1, 500.00, 'Ponstan 500mg Tablet (Mefenamic Acid)'),
(3, 3, 1, 30.00, 'Robitussin Syrup (Ambroxol 30mg/5mL)'),
(2, 7, 1, 20.00, 'Losec 20mg Capsule (Omeprazole)'),
(1, 6, 1, 500.00, 'Glucophage 500mg Tablet (Metformin)'),
(1, 4, 1, 50.00, 'Cozaar 50mg Tablet (Losartan)'),
(6, 3, 1, 2.50, 'Ventolin Nebule (Salbutamol 2.5mg/2.5mL)');

-- 8. SUPPLIER TABLE (5 rows)
INSERT INTO supplier_table (supplier_number, name, address, contact_number, email) VALUES
('SUP-0001', 'Metro Drug Corporation', '123 Aurora Blvd, Quezon City, Metro Manila', '028123456', 'orders@metrodrug.ph'),
('SUP-0002', 'Zuellig Pharma Corporation', 'Zuellig Bldg, Makati Ave, Makati City', '028234567', 'sales@zuelligpharma.ph'),
('SUP-0003', 'Diethelm Keller Philippines Inc.', '45 Ortigas Ave, Pasig City', '028345678', 'info@dkph.ph'),
('SUP-0004', 'MEDS Pharma Distribution Corp.', '88 EDSA, Mandaluyong City', '028456789', 'contact@medspharma.ph'),
('SUP-0005', 'RiteMed Distribution Center', '12 Commonwealth Ave, Quezon City', '028567890', 'distro@ritemed.ph'),
('SUP-0006', 'AM-Europharma Corporation', '56 Shaw Blvd, Mandaluyong City', '028678901', 'sales@ameuropharma.ph'),
('SUP-0007', 'Getz Pharma Philippines Inc.', '78 Julia Vargas Ave, Pasig City', '028789012', 'orders@getzpharma.ph'),
('SUP-0008', 'Southstar Drug Distribution', '34 National Highway, Alabang, Muntinlupa City', '028890123', 'info@southstardrug.ph'),
('SUP-0009', 'Mercury Drug Wholesale Division', '7 Mercury Ave, San Juan City', '028901234', 'wholesale@mercurydrug.ph'),
('SUP-0010', 'Watsons Distribution Center', '21 Congressional Ave, Quezon City', '028012345', 'supply@watsons.ph');

-- 9. ORDER TABLE (5 rows)
INSERT INTO order_table (creator_id, supplier_id, fulfillment_status, order_number, created_at, requested_at, approved_at, arrived_at, completed_at, cancelled_at, returned_at) VALUES
(7, 1, 'Completed', 'ORD-2026-0001', '2026-01-1 09:00:00', '2026-01-1 09:15:00', '2026-01-2 10:00:00', '2026-01-5 14:00:00', '2026-01-5 16:00:00', NULL, NULL),
(4, 4, 'Pending', 'ORD-2026-0002', '2026-02-2 09:00:00', NULL, NULL, NULL, NULL, NULL, NULL),
(8, 7, 'Completed', 'ORD-2026-0003', '2026-03-3 09:00:00', '2026-03-3 09:15:00', '2026-03-4 10:00:00', '2026-03-7 14:00:00', '2026-03-7 16:00:00', NULL, NULL),
(2, 10, 'Cancelled', 'ORD-2026-0004', '2026-04-4 09:00:00', '2026-04-4 09:15:00', NULL, NULL, NULL, '2026-04-6 11:00:00', NULL),
(3, 3, 'Approved', 'ORD-2026-0005', '2026-05-5 09:00:00', '2026-05-5 09:15:00', '2026-05-6 10:00:00', NULL, NULL, NULL, NULL),
(3, 6, 'Pending', 'ORD-2026-0006', '2026-06-6 09:00:00', NULL, NULL, NULL, NULL, NULL, NULL),
(7, 9, 'Completed', 'ORD-2026-0007', '2026-01-7 09:00:00', '2026-01-7 09:15:00', '2026-01-8 10:00:00', '2026-01-11 14:00:00', '2026-01-11 16:00:00', NULL, NULL),
(2, 2, 'Returned', 'ORD-2026-0008', '2026-02-8 09:00:00', '2026-02-8 09:15:00', '2026-02-9 10:00:00', '2026-02-12 14:00:00', NULL, NULL, '2026-02-14 09:00:00'),
(5, 5, 'Completed', 'ORD-2026-0009', '2026-03-9 09:00:00', '2026-03-9 09:15:00', '2026-03-10 10:00:00', '2026-03-13 14:00:00', '2026-03-13 16:00:00', NULL, NULL),
(2, 8, 'Approved', 'ORD-2026-0010', '2026-04-10 09:00:00', '2026-04-10 09:15:00', '2026-04-11 10:00:00', NULL, NULL, NULL, NULL);

-- 10. ORDER DETAIL TABLE
INSERT INTO order_detail_table (order_id, medicine_id, request_quantity) VALUES
(1, 2, 121),
(1, 7, 27),
(1, 4, 33),
(1, 9, 118),
(3, 1, 154),
(3, 2, 67),
(3, 10, 25),
(3, 10, 159),
(3, 7, 22),
(3, 4, 21),
(3, 9, 44),
(4, 5, 117),
(4, 3, 148),
(5, 2, 156),
(5, 5, 153),
(5, 3, 36),
(5, 10, 156),
(5, 4, 105),
(7, 2, 150),
(7, 2, 154),
(7, 1, 168),
(7, 4, 137),
(7, 9, 119),
(7, 6, 129),
(7, 10, 126),
(7, 6, 86),
(7, 4, 56),
(8, 4, 30),
(8, 10, 86),
(8, 9, 136),
(9, 6, 196),
(9, 8, 83),
(9, 10, 28),
(9, 2, 141),
(9, 7, 52),
(9, 6, 48),
(10, 8, 117);

-- 11. DELIVERY TABLE (10 rows)
INSERT INTO delivery_table (supplier_id, receiver_id, total_amount) VALUES 
INSERT INTO delivery_table (supplier_id, receiver_id, delivery_number, total_amount, received_date) VALUES
(1, 2, 'DEL-2026-0001', 4857.92, '2026-01-6 13:00:00'),
(4, 2, 'DEL-2026-0002', 33029.37, '2026-02-7 13:00:00'),
(7, 9, 'DEL-2026-0003', NULL, '2026-03-8 13:00:00'),
(10, 9, 'DEL-2026-0004', 25766.79, '2026-04-9 13:00:00'),
(3, 6, 'DEL-2026-0005', 5476.24, '2026-05-10 13:00:00'),
(6, 6, 'DEL-2026-0006', 10887.26, '2026-06-11 13:00:00'),
(9, 6, 'DEL-2026-0007', NULL, '2026-01-12 13:00:00'),
(2, 9, 'DEL-2026-0008', 30829.28, '2026-02-13 13:00:00'),
(5, 7, 'DEL-2026-0009', 17366.96, '2026-03-14 13:00:00'),
(8, 9, 'DEL-2026-0010', 618.35, '2026-04-15 13:00:00');

-- 12. DELIVERY DETAIL TABLE
INSERT INTO delivery_detail_table (delivery_id, medicine_id, order_detail_id, received_quantity, batch_number, expiry_date, unit_price) VALUES
(1, 8, 5, 480, 'BATCH-2026-0001', '2027-02-02 00:00:00', 3.67),
(1, 5, 31, 406, 'BATCH-2026-0002', '2027-02-02 00:00:00', 6.2),
(1, 1, 20, 381, 'BATCH-2026-0003', '2027-02-02 00:00:00', 1.52),
(2, 8, 19, 416, 'BATCH-2026-0004', '2027-03-03 00:00:00', 3.91),
(2, 6, 2, 286, 'BATCH-2026-0005', '2027-03-03 00:00:00', 58.27),
(2, 10, 8, 302, 'BATCH-2026-0006', '2027-03-03 00:00:00', 13.68),
(2, 5, 9, 428, 'BATCH-2026-0007', '2027-03-03 00:00:00', 5.7),
(2, 7, 32, 91, 'BATCH-2026-0008', '2027-03-03 00:00:00', 26.13),
(2, 7, 36, 192, 'BATCH-2026-0009', '2027-03-03 00:00:00', 30.15),
(4, 7, 36, 192, 'BATCH-2026-0010', '2027-05-05 00:00:00', 29.16),
(4, 6, 25, 168, 'BATCH-2026-0011', '2027-05-05 00:00:00', 55.81),
(4, 3, 10, 168, 'BATCH-2026-0012', '2027-05-05 00:00:00', 9.29),
(4, 1, 32, 475, 'BATCH-2026-0013', '2027-05-05 00:00:00', 1.53),
(4, 5, 19, 52, 'BATCH-2026-0014', '2027-05-05 00:00:00', 5.57),
(4, 9, 24, 362, 'BATCH-2026-0015', '2027-05-05 00:00:00', 11.15),
(4, 3, 33, 366, 'BATCH-2026-0016', '2027-05-05 00:00:00', 9.28),
(4, 1, 30, 495, 'BATCH-2026-0017', '2027-05-05 00:00:00', 1.58),
(5, 9, 26, 253, 'BATCH-2026-0018', '2027-06-06 00:00:00', 10.78),
(5, 2, 31, 374, 'BATCH-2026-0019', '2027-06-06 00:00:00', 7.35),
(6, 4, 5, 156, 'BATCH-2026-0020', '2027-01-07 00:00:00', 4.94),
(6, 2, 22, 357, 'BATCH-2026-0021', '2027-01-07 00:00:00', 6.83),
(6, 1, 37, 127, 'BATCH-2026-0022', '2027-01-07 00:00:00', 1.51),
(6, 6, 2, 86, 'BATCH-2026-0023', '2027-01-07 00:00:00', 64.49),
(6, 10, 25, 126, 'BATCH-2026-0024', '2027-01-07 00:00:00', 15.4),
(8, 6, 24, 292, 'BATCH-2026-0025', '2027-03-09 00:00:00', 55.47),
(8, 8, 30, 295, 'BATCH-2026-0026', '2027-03-09 00:00:00', 3.99),
(8, 2, 10, 102, 'BATCH-2026-0027', '2027-03-09 00:00:00', 7.87),
(8, 5, 31, 474, 'BATCH-2026-0028', '2027-03-09 00:00:00', 6.23),
(8, 9, 2, 155, 'BATCH-2026-0029', '2027-03-09 00:00:00', 11.99),
(8, 9, 24, 125, 'BATCH-2026-0030', '2027-03-09 00:00:00', 11.42),
(8, 1, 34, 202, 'BATCH-2026-0031', '2027-03-09 00:00:00', 1.64),
(8, 2, 17, 315, 'BATCH-2026-0032', '2027-03-09 00:00:00', 7.3),
(8, 3, 23, 445, 'BATCH-2026-0033', '2027-03-09 00:00:00', 8.5),
(9, 9, 33, 218, 'BATCH-2026-0034', '2027-04-10 00:00:00', 11.3),
(9, 10, 13, 462, 'BATCH-2026-0035', '2027-04-10 00:00:00', 14.22),
(9, 7, 15, 152, 'BATCH-2026-0036', '2027-04-10 00:00:00', 28.1),
(9, 6, 2, 64, 'BATCH-2026-0037', '2027-04-10 00:00:00', 63.48),
(10, 8, 17, 149, 'BATCH-2026-0038', '2027-05-11 00:00:00', 4.15);

-- 13. MEDICINE STOCK TABLE
INSERT INTO medicine_stock_table (delivery_detail_id, current_stock_quantity) VALUES
(1, 176),
(2, 228),
(3, 370),
(4, 178),
(5, 186),
(6, 41),
(7, 112),
(8, 13),
(9, 58),
(10, 120),
(11, 50),
(12, 86),
(13, 104),
(14, 30),
(15, 319),
(16, 312),
(17, 430),
(18, 0),
(19, 245),
(20, 88),
(21, 329),
(22, 21),
(23, 84),
(24, 15),
(25, 198),
(26, 102),
(27, 61),
(28, 455),
(29, 45),
(30, 55),
(31, 202),
(32, 170),
(33, 44),
(34, 205),
(35, 369),
(36, 101),
(37, 59),
(38, 102);

-- 14. SALES TABLE (5 rows)
INSERT INTO sales_table (customer_type_id, sales_number, payment_method, total_amount, discounted_amount, is_prescribed, created_at) VALUES
(1, 'SAL-2026-0001', 'Cash', 700.0, 700.0, 0, '2026-02-02 10:07:00'),
(2, 'SAL-2026-0002', 'GCash', 0.0, 0.0, 0, '2026-03-03 10:14:00'),
(1, 'SAL-2026-0003', 'Credit Card', 228.5, 228.5, 1, '2026-04-04 10:21:00'),
(3, 'SAL-2026-0004', 'Debit Card', 1435.0, 1148.0, 0, '2026-05-05 10:28:00'),
(1, 'SAL-2026-0005', 'Maya', 318.0, 318.0, 0, '2026-06-06 10:35:00'),
(4, 'SAL-2026-0006', 'Cash', 905.5, 860.22, 1, '2026-01-07 10:42:00'),
(2, 'SAL-2026-0007', 'GCash', 2763.0, 2210.4, 0, '2026-02-08 10:49:00'),
(1, 'SAL-2026-0008', 'Credit Card', 0.0, 0.0, 0, '2026-03-09 10:56:00'),
(5, 'SAL-2026-0009', 'Debit Card', 1335.5, 1201.95, 1, '2026-04-10 10:03:00'),
(1, 'SAL-2026-0010', 'Maya', 60.0, 60.0, 0, '2026-05-11 10:10:00');

-- 15. SALES DETAILS TABLE
INSERT INTO sales_details_table (sales_id, medicine_stock_id, quantity, sub_total_amount) VALUES
(1, 6, 6, 90.0),
(1, 9, 5, 12.5),
(1, 38, 5, 32.5),
(1, 31, 5, 475.0),
(1, 36, 5, 90.0),
(3, 2, 4, 10.0),
(3, 34, 14, 210.0),
(3, 13, 1, 8.5),
(4, 17, 10, 85.0),
(4, 33, 19, 161.5),
(4, 21, 18, 180.0),
(4, 27, 2, 30.0),
(4, 23, 19, 123.5),
(4, 34, 17, 765.0),
(4, 9, 5, 90.0),
(5, 34, 1, 18.0),
(5, 29, 20, 300.0),
(6, 1, 6, 90.0),
(6, 10, 20, 130.0),
(6, 8, 2, 36.0),
(6, 21, 17, 306.0),
(6, 36, 4, 26.0),
(6, 36, 8, 20.0),
(6, 13, 2, 20.0),
(6, 7, 15, 270.0),
(6, 36, 3, 7.5),
(7, 29, 20, 1900.0),
(7, 33, 17, 425.0),
(7, 13, 15, 150.0),
(7, 33, 16, 288.0),
(9, 33, 17, 144.5),
(9, 17, 7, 126.0),
(9, 29, 14, 210.0),
(9, 8, 15, 675.0),
(9, 21, 8, 96.0),
(9, 28, 7, 84.0),
(10, 20, 5, 60.0);

-- 16. SALES CUSTOMER TYPE DETAILS
INSERT INTO sales_customer_type_detail_table (sales_id, customer_type_id, id_number) VALUES
(2, 2, 'ID-1001'),
(4, 3, 'ID-1002'),
(6, 4, 'ID-1003'),
(7, 2, 'ID-1004'),
(9, 5, 'ID-1005');

-- Run procedure and cleanup
CALL PopulateChildTables();
DROP PROCEDURE IF EXISTS PopulateChildTables;

Select * From user_table;
Select * From delivery_table;

SELECT COUNT(delivery_id) AS totalDeliveryCount FROM delivery_table;