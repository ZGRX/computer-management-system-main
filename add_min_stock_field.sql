-- 添加库存预警阈值字段
ALTER TABLE computer_part ADD COLUMN min_stock INT NOT NULL DEFAULT 10 COMMENT '最小库存预警阈值';

-- 为现有数据设置默认预警值
UPDATE computer_part SET min_stock = 10 WHERE min_stock IS NULL OR min_stock = 0;
