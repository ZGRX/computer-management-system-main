-- 添加库存预警阈值字段
ALTER TABLE computer_part 
ADD COLUMN min_stock INT NOT NULL DEFAULT 10 COMMENT '最小库存预警阈值' AFTER stock;

-- 更新现有数据的min_stock为10
UPDATE computer_part SET min_stock = 10 WHERE min_stock IS NULL;
