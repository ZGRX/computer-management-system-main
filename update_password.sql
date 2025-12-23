-- 更新用户密码（密码：123456）
USE computer_part_management;

UPDATE user SET password = '$2a$10$gDtlI20COgH54hhkVvGI9uBKKfRmCDvL4GxJ.LU9dKUQoPZBVugMC' WHERE username = 'admin';
UPDATE user SET password = '$2a$10$gDtlI20COgH54hhkVvGI9uBKKfRmCDvL4GxJ.LU9dKUQoPZBVugMC' WHERE username = 'customer';

SELECT id, username, email, role, 'Password updated successfully' as status
FROM user 
WHERE username IN ('admin', 'customer');
