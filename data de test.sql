INSERT INTO customers (first_name, last_name, phone, email, street, city, state, zip_code)
VALUES
('Amine', 'El Amrani', '+212612345678', 'amine.elamrani@example.com', '123 Elm Street', 'Casablanca', 'Casablanca-Settat', 20000),
('Fatima', 'Ben Ali', '+212612345679', 'fatima.benali@example.com', '456 Maple Avenue', 'Rabat', 'Rabat-Salé-Kénitra', 10000),
('Youssef', 'Bouazza', '+212612345680', 'youssef.bouazza@example.com', '789 Oak Lane', 'Marrakech', 'Marrakech-Safi', 40000),
('Khadija', 'Bensalah', '+212612345681', 'khadija.bensalah@example.com', '321 Pine Road', 'Tangier', 'Tanger-Tetouan-Al Hoceima', 90000),
('Mohamed', 'El Idrissi', '+212612345682', 'mohamed.elidrissi@example.com', '654 Cedar Drive', 'Fes', 'Fès-Meknès', 30000),
('Sara', 'Ouazzani', '+212612345683', 'sara.ouazzani@example.com', '987 Birch Boulevard', 'Agadir', 'Souss-Massa', 80000),
('Hassan', 'Rachidi', '+212612345684', 'hassan.rachidi@example.com', '159 Spruce Street', 'Oujda', 'Oriental', 60000),
('Nadia', 'Bouraoui', '+212612345685', 'nadia.bouraoui@example.com', '753 Fir Lane', 'Kenitra', 'Rabat-Salé-Kénitra', 14000),
('Omar', 'El Yacoubi', '+212612345686', 'omar.elyacoubi@example.com', '852 Willow Road', 'Meknes', 'Fès-Meknès', 50000),
('Latifa', 'El Khamlichi', '+212612345687', 'latifa.elkhamlichi@example.com', '951 Aspen Avenue', 'Tetouan', 'Tanger-Tetouan-Al Hoceima', 93000),
('Rachid', 'Mahmoudi', '+212612345688', 'rachid.mahmoudi@example.com', '753 Cypress Boulevard', 'Nador', 'Oriental', 62000),
('Souad', 'Alaoui', '+212612345689', 'souad.alaoui@example.com', '456 Hemlock Street', 'Laayoune', 'Laâyoune-Sakia El Hamra', 70000),
('Mustapha', 'Nassiri', '+212612345690', 'mustapha.nassiri@example.com', '789 Redwood Drive', 'Errachidia', 'Drâa-Tafilalet', 52000),
('Zineb', 'Mellouki', '+212612345691', 'zineb.mellouki@example.com', '123 Sequoia Lane', 'El Jadida', 'Casablanca-Settat', 24000),
('Khalid', 'Zouaoui', '+212612345692', 'khalid.zouaoui@example.com', '456 Alder Road', 'Safi', 'Marrakech-Safi', 46000);

INSERT INTO stores (store_name, phone, email, street, city, state, zip_code)
VALUES
('Casablanca Central', '+212522123456', 'casablanca.central@example.com', '123 Mohammed V Blvd', 'Casablanca', 'Casablanca-Settat', 20000),
('Rabat Retail', '+212537123456', 'rabat.retail@example.com', '456 Hassan II Avenue', 'Rabat', 'Rabat-Salé-Kénitra', 10000),
('Marrakech Market', '+212524123456', 'marrakech.market@example.com', '789 Menara St', 'Marrakech', 'Marrakech-Safi', 40000),
('Tangier Trade', '+212539123456', 'tangier.trade@example.com', '321 Riad Tetouan', 'Tangier', 'Tanger-Tetouan-Al Hoceima', 90000),
('Fes Fair', '+212535123456', 'fes.fair@example.com', '654 Borj Nord', 'Fes', 'Fès-Meknès', 30000),
('Agadir Agora', '+212528123456', 'agadir.agora@example.com', '987 Ocean Drive', 'Agadir', 'Souss-Massa', 80000),
('Oujda Outlet', '+212536123456', 'oujda.outlet@example.com', '159 Ziri Ibn Attiya Blvd', 'Oujda', 'Oriental', 60000),
('Kenitra Kiosk', '+212537234567', 'kenitra.kiosk@example.com', '753 Ibn Batouta St', 'Kenitra', 'Rabat-Salé-Kénitra', 14000),
('Meknes Mall', '+212535234567', 'meknes.mall@example.com', '852 Volubilis Ave', 'Meknes', 'Fès-Meknès', 50000),
('Tetouan Trading', '+212539234567', 'tetouan.trading@example.com', '951 Martil Blvd', 'Tetouan', 'Tanger-Tetouan-Al Hoceima', 93000),
('Nador Nexus', '+212536234567', 'nador.nexus@example.com', '753 Selouane Ave', 'Nador', 'Oriental', 62000),
('Laayoune Plaza', '+212528234567', 'laayoune.plaza@example.com', '456 Wadi Dahab Blvd', 'Laayoune', 'Laâyoune-Sakia El Hamra', 70000),
('Errachidia Emporium', '+212535345678', 'errachidia.emporium@example.com', '789 Tafilalet St', 'Errachidia', 'Drâa-Tafilalet', 52000),
('El Jadida Junction', '+212523345678', 'eljadida.junction@example.com', '123 Deauville St', 'El Jadida', 'Casablanca-Settat', 24000),
('Safi Storehouse', '+212524345678', 'safi.storehouse@example.com', '456 Souira Avenue', 'Safi', 'Marrakech-Safi', 46000);

INSERT INTO staffs (first_name, last_name, phone, email, active, store_id, manager_id)
VALUES
('Ahmed', 'El Khalfi', '+212522111111', 'ahmed.elkhalfi@example.com', 'active', 1, NULL),
('Fatima', 'Bennani', '+212537111111', 'fatima.bennani@example.com', 'active', 2, 1),
('Youssef', 'Alaoui', '+212524111111', 'youssef.alaoui@example.com', 'active', 3, 1),
('Khadija', 'Moulay', '+212539111111', 'khadija.moulay@example.com', 'active', 4, 2),
('Mohammed', 'Ouazzani', '+212535111111', 'mohammed.ouazzani@example.com', 'inactive', 5, 3),
('Samira', 'El Mansouri', '+212528111111', 'samira.elmansouri@example.com', 'active', 6, 4),
('Rachid', 'Fassi', '+212536111111', 'rachid.fassi@example.com', 'active', 7, 2),
('Nadia', 'Zahraoui', '+212537222222', 'nadia.zahraoui@example.com', 'active', 8, 5),
('Hicham', 'Boujemaoui', '+212535222222', 'hicham.boujemaoui@example.com', 'inactive', 9, 6),
('Layla', 'Sebti', '+212539222222', 'layla.sebti@example.com', 'active', 10, 7),
('Omar', 'Dib', '+212536222222', 'omar.dib@example.com', 'active', 11, 8),
('Imane', 'Kebir', '+212528222222', 'imane.kebir@example.com', 'active', 12, 3),
('Anas', 'Mahmoudi', '+212523222222', 'anas.mahmoudi@example.com', 'inactive', 13, 9),
('Salma', 'Haddioui', '+212524222222', 'salma.haddioui@example.com', 'active', 14, 10),
('Zakaria', 'Amrani', '+212528333333', 'zakaria.amrani@example.com', 'active', 15, 4);

INSERT INTO categories (category_name)
VALUES
('Electronics'),
('Clothing'),
('Home Appliances'),
('Books'),
('Toys'),
('Sports Equipment'),
('Beauty Products'),
('Automotive'),
('Furniture'),
('Jewelry');

INSERT INTO brands (brand_name)
VALUES
('Samsung'),
('Nike'),
('Whirlpool'),
('Penguin'),
('Lego'),
('Adidas'),
('Oreal'),
('Toyota'),
('Ikea'),
('Tiffany');

INSERT INTO products (product_name, brand_id, category_id, model_year, list_price)
VALUES
('Galaxy S21', 1, 1, 2023, 999),
('Galaxy Tab S7', 1, 1, 2023, 649),
('Air Force 1', 2, 2, 2023, 90),
('LeBron 18', 2, 2, 2023, 200),
('Front Load Washer', 3, 3, 2023, 799),
('French Door ', 3, 3, 2023, 1599),
('Casual Shirt', 4, 4, 2023, 69),
('Formal Suit', 4, 4, 2023, 299),
('LEGO Creator ', 5, 5, 2023, 149),
('LEGO Star Wars ', 5, 5, 2023, 799),
('Ultraboost', 6, 6, 2023, 180),
('NMD R1', 6, 6, 2023, 130),
('Revitalift Anti', 7, 7, 2023, 24),
('Infallible Pr', 7, 7, 2023, 10),
('Camry', 8, 8, 2023, 24999),
('Corolla', 8, 8, 2023, 20999),
('Billy Bookcase', 9, 9, 2023, 49),
('MALM Bed Frame', 9, 9, 2023, 199),
('Diamond Engageme', 10, 10, 2023, 5000),
('Tiffany T True', 10, 10, 2023, 1900),
('iPhone 14', 1, 1, 2024, 1099),
('Galaxy Watch 5', 1, 1, 2024, 399),
('Air Jordan 1', 2, 2, 2024, 170),
('LeBron 19', 2, 2, 2024, 200),
('Top Load Washer', 3, 3, 2024, 699),
('Side-by-Side ', 3, 3, 2024, 1799),
('Polo Shirt', 4, 4, 2024, 49),
('Slim Fit Trousers', 4, 4, 2024, 99),
('LEGO Architecture ', 5, 5, 2024, 119),
('LEGO Technic Lambor', 5, 5, 2024, 379),
('Superstar', 6, 6, 2024, 80),
('Stan Smith', 6, 6, 2024, 85),
('Revitalift Volume', 7, 7, 2024, 27),
('Color Riche Matte L', 7, 7, 2024, 8),
('RAV4', 8, 8, 2024, 27999),
('Highlander', 8, 8, 2024, 31999),
('BILLY/OXBERG Bookc', 9, 9, 2024, 69),
('HEMNES Bed Frame', 9, 9, 2024, 229),
('Soleste Yellow', 10, 10, 2024, 7000),
('Tiffany T1 Wide ', 10, 10, 2024, 3200),
('Galaxy S22', 1, 1, 2025, 899),
('Galaxy Tab S8', 1, 1, 2025, 749),
('Air Max 1', 2, 2, 2025, 120),
('Kyrie 9', 2, 2, 2025, 160),
('Front Load Dryer', 3, 3, 2025, 899),
('French Door Countr', 3, 3, 2025, 2499),
('Denim Jacket', 4, 4, 2025, 79),
('Chino Shorts', 4, 4, 2025, 39),
('LEGO Star Wars ', 5, 5, 2025, 699),
('LEGO Technic ', 5, 5, 2025, 349),
('UltraBOOST 22', 6, 6, 2025, 190),
('Superstar 2.0', 6, 6, 2025, 90),
('Revitalift Bright', 7, 7, 2025, 20),
('True Match Super-', 7, 7, 2025, 11),
('Camry Hybrid', 8, 8, 2025, 30999),
('RAV4 Hybrid', 8, 8, 2025, 31999),
('BILLY Bookcase ', 9, 9, 2025, 129),
('MALM Ottoman Bed', 9, 9, 2025, 499),
('Soleste Blue Dia', 10, 10, 2025, 8500),
('Tiffany HardWear', 10, 10, 2025, 2900);

-- Products in Store 1
INSERT INTO stocks (store_id, product_id, quantity)
VALUES
(1, 1, 100),
(1, 2, 50),
(1, 3, 75),
(1, 4, 30),
(1, 5, 20),
(1, 6, 10),
(1, 7, 40),
(1, 8, 25),
(1, 9, 60),
(1, 10, 15),
(1, 11, 80),
(1, 12, 70),
(1, 13, 90),
(1, 14, 85),
(1, 15, 55),
(1, 16, 45),
(1, 17, 25),
(1, 18, 35),
(1, 19, 65),
(1, 20, 10),
(1, 21, 100),
(1, 22, 50),
(1, 23, 75),
(1, 24, 30),
(1, 25, 20),
(1, 26, 10),
(1, 27, 40),
(1, 28, 25),
(1, 29, 60),
(1, 30, 15),
(1, 31, 80),
(1, 32, 70),
(1, 33, 90),
(1, 34, 85),
(1, 35, 55),
(1, 36, 45),
(1, 37, 25),
(1, 38, 35),
(1, 39, 65),
(1, 40, 10),
(1, 41, 100),
(1, 42, 50),
(1, 43, 75),
(1, 44, 30),
(1, 45, 20),
(1, 46, 10),
(1, 47, 40),
(1, 48, 25),
(1, 49, 60),
(1, 50, 15);

-- Products in Store 2
INSERT INTO stocks (store_id, product_id, quantity)
VALUES
(2, 1, 150),
(2, 2, 100),
(2, 3, 125),
(2, 4, 50),
(2, 5, 40),
(2, 6, 20),
(2, 7, 60),
(2, 8, 45),
(2, 9, 80),
(2, 10, 25),
(2, 11, 110),
(2, 12, 90),
(2, 13, 120),
(2, 14, 105),
(2, 15, 75),
(2, 16, 65),
(2, 17, 45),
(2, 18, 55),
(2, 19, 85),
(2, 20, 20),
(2, 21, 150),
(2, 22, 100),
(2, 23, 125),
(2, 24, 50),
(2, 25, 40),
(2, 26, 20),
(2, 27, 60),
(2, 28, 45),
(2, 29, 80),
(2, 30, 25),
(2, 31, 110),
(2, 32, 90),
(2, 33, 120),
(2, 34, 105),
(2, 35, 75),
(2, 36, 65),
(2, 37, 45),
(2, 38, 55),
(2, 39, 85),
(2, 40, 20),
(2, 41, 150),
(2, 42, 100),
(2, 43, 125),
(2, 44, 50),
(2, 45, 40),
(2, 46, 20),
(2, 47, 60),
(2, 48, 45),
(2, 49, 80),
(2, 50, 25);

-- Products in Store 3
INSERT INTO stocks (store_id, product_id, quantity)
VALUES
(3, 1, 200),
(3, 2, 150),
(3, 3, 175),
(3, 4, 70),
(3, 5, 60),
(3, 6, 30),
(3, 7, 80),
(3, 8, 60),
(3, 9, 100),
(3, 10, 35),
(3, 11, 140),
(3, 12, 120),
(3, 13, 150),
(3, 14, 130),
(3, 15, 95),
(3, 16, 80),
(3, 17, 55),
(3, 18, 70),
(3, 19, 110),
(3, 20, 30),
(3, 21, 200),
(3, 22, 150),
(3, 23, 175),
(3, 24, 70),
(3, 25, 60),
(3, 26, 30),
(3, 27, 80),
(3, 28, 60),
(3, 29, 100),
(3, 30, 35),
(3, 31, 140),
(3, 32, 120),
(3, 33, 150),
(3, 34, 130),
(3, 35, 95),
(3, 36, 80),
(3, 37, 55),
(3, 38, 70),
(3, 39, 110),
(3, 40, 30),
(3, 41, 200),
(3, 42, 150),
(3, 43, 175),
(3, 44, 70),
(3, 45, 60),
(3, 46, 30),
(3, 47, 80),
(3, 48, 60),
(3, 49, 100),
(3, 50, 35);


-- Orders
INSERT INTO orders (customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
VALUES
(1, 'confirmed', '2024-05-20', '2024-05-25', NULL, 1, 1),
(2, 'confirmed', '2024-05-21', '2024-05-26', NULL, 2, 2),
(3, 'in process', '2024-05-22', '2024-05-27', NULL, 3, 3),
(4, 'confirmed', '2024-05-23', '2024-05-28', NULL, 4, 4),
(5, 'in process', '2024-05-24', '2024-05-29', NULL, 5, 5),
(6, 'confirmed', '2024-05-25', '2024-05-30', NULL, 1, 1),
(7, 'in process', '2024-05-26', '2024-05-31', NULL, 2, 2),
(8, 'confirmed', '2024-05-27', '2024-06-01', NULL, 3, 3),
(9, 'confirmed', '2024-05-28', '2024-06-02', NULL, 4, 4),
(10, 'in process', '2024-05-29', '2024-06-03', NULL, 5, 5);

-- Order Items for Order 1
INSERT INTO order_items (order_id, product_id, quantity, list_price, discount)
VALUES
(1, 1, 2, 100, 0),
(1, 3, 1, 75, 0),
(1, 5, 3, 50, 10),
(1, 7, 1, 40, 5),
(1, 9, 2, 60, 0),
(1, 11, 1, 80, 0),
(1, 13, 2, 90, 15),
(1, 15, 1, 55, 0),
(1, 17, 3, 30, 0),
(1, 19, 1, 65, 0);

-- Order Items for Order 2
INSERT INTO order_items (order_id, product_id, quantity, list_price, discount)
VALUES
(2, 2, 3, 150, 0),
(2, 4, 1, 60, 0),
(2, 6, 2, 80, 0),
(2, 8, 1, 45, 0),
(2, 10, 2, 30, 5),
(2, 12, 3, 70, 0),
(2, 14, 1, 85, 0),
(2, 16, 2, 45, 10),
(2, 18, 1, 35, 0),
(2, 20, 3, 40, 0);

-- Order Items for Order 3
INSERT INTO order_items (order_id, product_id, quantity, list_price, discount)
VALUES
(3, 3, 1, 75, 0),
(3, 5, 2, 50, 0),
(3, 7, 1, 40, 0),
(3, 9, 3, 60, 0),
(3, 11, 1, 80, 5),
(3, 13, 2, 90, 0),
(3, 15, 2, 55, 0),
(3, 17, 1, 30, 0),
(3, 19, 3, 65, 0),
(3, 21, 1, 100, 0);

-- Order Items for Order 4
INSERT INTO order_items (order_id, product_id, quantity, list_price, discount)
VALUES
(4, 4, 2, 60, 0),
(4, 6, 1, 80, 0),
(4, 8, 3, 45, 0),
(4, 10, 1, 30, 0),
(4, 12, 2, 70, 0),
(4, 14, 2, 85, 0),
(4, 16, 1, 45, 0),
(4, 18, 3, 35, 10),
(4, 20, 1, 40, 0),
(4, 22, 2, 50, 0);

-- Order Items for Order 5
INSERT INTO order_items (order_id, product_id, quantity, list_price, discount)
VALUES
(5, 5, 3, 50, 0),
(5, 7, 1, 40, 0),
(5, 9, 2, 60, 0),
(5, 11, 1, 80, 0),
(5, 13, 3, 90, 5),
(5, 15, 1, 55, 0),
(5, 17, 2, 30, 0),
(5, 19, 1, 65, 0),
(5, 21, 2, 100, 0),
(5, 23, 3, 75, 0);

-- Continue with more orders and order items as needed...
-- Order Items for Order 6
INSERT INTO order_items (order_id, product_id, quantity, list_price, discount)
VALUES
(6, 6, 2, 80, 0),
(6, 8, 1, 45, 0),
(6, 10, 3, 30, 0),
(6, 12, 1, 70, 0),
(6, 14, 2, 85, 0),
(6, 16, 2, 45, 0),
(6, 18, 1, 35, 0),
(6, 20, 3, 40, 0),
(6, 22, 1, 50, 0),
(6, 24, 2, 60, 0);

-- Order Items for Order 7
INSERT INTO order_items (order_id, product_id, quantity, list_price, discount)
VALUES
(7, 7, 1, 40, 0),
(7, 9, 2, 60, 0),
(7, 11, 3, 80, 0),
(7, 13, 1, 90, 0),
(7, 15, 2, 55, 0),
(7, 17, 2, 30, 0),
(7, 19, 1, 65, 0),
(7, 21, 3, 100, 0),
(7, 23, 1, 75, 0),
(7, 25, 2, 45, 0);

-- Order Items for Order 8
INSERT INTO order_items (order_id, product_id, quantity, list_price, discount)
VALUES
(8, 8, 3, 45, 0),
(8, 10, 1, 30, 0),
(8, 12, 2, 70, 0),
(8, 14, 1, 85, 0),
(8, 16, 2, 45, 0),
(8, 18, 3, 35, 0),
(8, 20, 1, 40, 0),
(8, 22, 2, 50, 0),
(8, 24, 1, 60, 0),
(8, 26, 3, 80, 0);

-- Order Items for Order 9
INSERT INTO order_items (order_id, product_id, quantity, list_price, discount)
VALUES
(9, 9, 2, 60, 0),
(9, 11, 1, 80, 0),
(9, 13, 3, 90, 0),
(9, 15, 2, 55, 0),
(9, 17, 2, 30, 0),
(9, 19, 1, 65, 0),
(9, 21, 3, 100, 0),
(9, 23, 1, 75, 0),
(9, 25, 2, 45, 0),
(9, 27, 1, 70, 0);

-- Order Items for Order 10
INSERT INTO order_items (order_id, product_id, quantity, list_price, discount)
VALUES
(10, 10, 1, 30, 0),
(10, 12, 2, 70, 0),
(10, 14, 1, 85, 0),
(10, 16, 2, 45, 0),
(10, 18, 3, 35, 0),
(10, 20, 1, 40, 0),
(10, 22, 2, 50, 0),
(10, 24, 1, 60, 0),
(10, 26, 3, 80, 0),
(10, 28, 2, 55, 0);

-- Continue with more orders and order items as needed...

