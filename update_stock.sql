-- 更新配件库存（根据入库和出库记录计算）
USE computer_part_management;

-- 更新所有配件的库存 = 入库数量 - 出库数量
UPDATE computer_part cp
SET stock = (
    COALESCE((SELECT SUM(quantity) FROM computer_part_stockin WHERE computer_part_id = cp.id), 0) - 
    COALESCE((SELECT SUM(quantity) FROM computer_part_stockout WHERE computer_part_id = cp.id), 0)
);

-- Display updated stock
SELECT 
  cp.id,
  cp.name,
  COALESCE((SELECT SUM(quantity) FROM computer_part_stockin WHERE computer_part_id = cp.id), 0) as stock_in,
  COALESCE((SELECT SUM(quantity) FROM computer_part_stockout WHERE computer_part_id = cp.id), 0) as stock_out,
  cp.stock as current_stock
FROM computer_part cp
ORDER BY cp.id
LIMIT 15;
