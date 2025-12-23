USE computer_part_management;

-- 检查配件总数
SELECT COUNT(*) as total_parts FROM computer_part;

-- 检查配件详情
SELECT id, name, stock, min_stock, price FROM computer_part LIMIT 5;

-- 检查库存不足的配件
SELECT COUNT(*) as low_stock_count FROM computer_part WHERE stock < min_stock;

-- 检查缺货的配件
SELECT COUNT(*) as out_of_stock_count FROM computer_part WHERE stock = 0;
