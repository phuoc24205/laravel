
-- 1. Lấy ra danh sách người dùng theo thứ tự tên theo Alphabet (A->Z)
SELECT * FROM users ORDER BY user_name ASC;

-- 2. Lấy ra 07 người dùng theo thứ tự tên theo Alphabet (A->Z)
SELECT * FROM users ORDER BY user_name ASC LIMIT 7;

-- 3. Lấy ra danh sách người dùng theo thứ tự Alphabet (A->Z), trong đó tên có chữ 'a'
SELECT * FROM users WHERE user_name LIKE '%a%' ORDER BY user_name ASC;

-- 4. Lấy ra danh sách người dùng có tên bắt đầu bằng chữ 'm'
SELECT * FROM users WHERE user_name LIKE 'm%';

-- 5. Lấy ra danh sách người dùng có tên kết thúc bằng chữ 'i'
SELECT * FROM users WHERE user_name LIKE '%i';

-- 6. Lấy ra danh sách người dùng có email là Gmail
SELECT * FROM users WHERE user_email LIKE '%@gmail.com';

-- 7. Lấy ra danh sách người dùng có email là Gmail và tên bắt đầu bằng 'm'
SELECT * FROM users WHERE user_email LIKE '%@gmail.com' AND user_name LIKE 'm%';

-- 8. Lấy ra danh sách người dùng có email là Gmail, tên chứa chữ 'i' và dài hơn 5 ký tự
SELECT * FROM users WHERE user_email LIKE '%@gmail.com' AND user_name LIKE '%i%' AND LENGTH(user_name) > 5;

-- 9. Lấy danh sách người dùng có tên chứa chữ 'a', dài 5-9 ký tự, email là Gmail, tên email có chữ 'i'
SELECT * FROM users WHERE user_name LIKE '%a%' AND LENGTH(user_name) BETWEEN 5 AND 9 AND user_email LIKE '%@gmail.com%' AND user_email LIKE '%i%';

-- 10. Lấy danh sách người dùng có điều kiện về tên và email
SELECT * FROM users WHERE (user_name LIKE '%a%' AND LENGTH(user_name) BETWEEN 5 AND 9) 
   OR (user_name LIKE '%i%' AND LENGTH(user_name) < 9) 
   OR (user_email LIKE '%@gmail.com%' AND user_email LIKE '%i%');