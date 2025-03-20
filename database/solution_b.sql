

-- 1. Liệt kê hóa đơn của khách hàng (mã user, tên user, mã hóa đơn)
SELECT users.user_id, users.user_name, orders.order_id 
FROM users 
JOIN orders ON users.user_id = orders.user_id;

-- 2. Liệt kê số lượng hóa đơn của khách hàng
SELECT users.user_id, users.user_name, COUNT(orders.order_id) AS total_orders
FROM users 
LEFT JOIN orders ON users.user_id = orders.user_id
GROUP BY users.user_id, users.user_name;

-- 3. Liệt kê thông tin hóa đơn: mã đơn hàng, số sản phẩm
SELECT order_details.order_id, COUNT(order_details.product_id) AS total_products
FROM order_details
GROUP BY order_details.order_id;

-- 4. Liệt kê thông tin mua hàng của người dùng, nhóm theo đơn hàng
SELECT users.user_id, users.user_name, orders.order_id, GROUP_CONCAT(products.product_name) AS product_list
FROM users 
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
GROUP BY users.user_id, users.user_name, orders.order_id;

-- 5. Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất
SELECT users.user_id, users.user_name, COUNT(orders.order_id) AS total_orders
FROM users 
JOIN orders ON users.user_id = orders.user_id
GROUP BY users.user_id, users.user_name
ORDER BY total_orders DESC
LIMIT 7;

-- 6. Liệt kê 7 người dùng mua sản phẩm Samsung hoặc Apple
SELECT DISTINCT users.user_id, users.user_name, orders.order_id, products.product_name
FROM users 
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
WHERE products.product_name LIKE '%Samsung%' OR products.product_name LIKE '%Apple%'
LIMIT 7;

-- 7. Liệt kê danh sách mua hàng của user bao gồm tổng tiền mỗi đơn hàng
SELECT users.user_id, users.user_name, orders.order_id, SUM(order_details.price * order_details.quantity) AS total_price
FROM users 
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY users.user_id, users.user_name, orders.order_id;

-- 8. Mỗi user chỉ chọn ra 1 đơn hàng có giá trị lớn nhất
SELECT users.user_id, users.user_name, orders.order_id, SUM(order_details.price * order_details.quantity) AS total_price
FROM users 
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY users.user_id, users.user_name, orders.order_id
HAVING total_price = (SELECT MAX(total_price) FROM (SELECT orders.user_id, SUM(order_details.price * order_details.quantity) AS total_price FROM orders JOIN order_details ON orders.order_id = order_details.order_id GROUP BY orders.user_id, orders.order_id) AS subquery);

-- 9. Mỗi user chỉ chọn ra 1 đơn hàng có giá trị nhỏ nhất
SELECT users.user_id, users.user_name, orders.order_id, SUM(order_details.price * order_details.quantity) AS total_price
FROM users 
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY users.user_id, users.user_name, orders.order_id
HAVING total_price = (SELECT MIN(total_price) FROM (SELECT orders.user_id, SUM(order_details.price * order_details.quantity) AS total_price FROM orders JOIN order_details ON orders.order_id = order_details.order_id GROUP BY orders.user_id, orders.order_id) AS subquery);

-- 10. Mỗi user chỉ chọn ra 1 đơn hàng có số sản phẩm là nhiều nhất
SELECT users.user_id, users.user_name, orders.order_id, COUNT(order_details.product_id) AS total_products
FROM users 
JOIN orders ON users.user_id = orders.user_id
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY users.user_id, users.user_name, orders.order_id
HAVING total_products = (SELECT MAX(total_products) FROM (SELECT orders.user_id, COUNT(order_details.product_id) AS total_products FROM orders JOIN order_details ON orders.order_id = order_details.order_id GROUP BY orders.user_id, orders.order_id) AS subquery);