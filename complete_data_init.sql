-- 完整的电脑配件销售系统数据初始化脚本（重置版）
USE computer_part_management;

-- ========== 清空所有依赖表（倒序清空以避免外键冲突）==========
DELETE FROM computer_part_stockout;
DELETE FROM computer_part_stockin;
DELETE FROM computer_part;
DELETE FROM computer_part_category;

-- ========== 重置AUTO_INCREMENT ==========
ALTER TABLE computer_part_category AUTO_INCREMENT = 1;
ALTER TABLE computer_part AUTO_INCREMENT = 1;
ALTER TABLE computer_part_stockin AUTO_INCREMENT = 1;
ALTER TABLE computer_part_stockout AUTO_INCREMENT = 1;

-- ========== 插入电脑配件分类 ==========
INSERT INTO computer_part_category (name, description) VALUES
('CPU处理器', '中央处理器，计算机的核心部件'),
('主板', '连接所有硬件组件的主要电路板'),
('内存', '计算机运行内存，提升系统性能'),
('存储设备', '硬盘和SSD等存储介质'),
('显卡', '图形处理器，用于3D渲染和游戏'),
('电源', '为计算机提供稳定的电力供应'),
('冷却散热', '散热器和风扇等冷却设备'),
('外设配件', '键盘、鼠标等外围设备');

-- ========== 插入电脑配件数据 ==========
INSERT INTO computer_part (name, category_id, specification, unit, price, stock, description, created_at) VALUES
-- CPU处理器 (category_id = 1)
('Intel Core i9-13900K', 1, '8核16线程', '个', 4599.00, 0, '高端处理器，适合游戏和工作站', NOW()),
('AMD Ryzen 9 7900X', 1, '12核24线程', '个', 3999.00, 0, '高性能多核处理器', NOW()),
('Intel Core i5-13600K', 1, '6核12线程', '个', 2299.00, 0, '中端处理器，性价比高', NOW()),

-- 主板 (category_id = 2)
('华硕ROG STRIX Z790', 2, 'LGA1700', '个', 2899.00, 0, '旗舰级游戏主板', NOW()),
('微星MPG B650', 2, 'AM5', '个', 1899.00, 0, '高性能消费级主板', NOW()),
('技嘉B660M', 2, 'LGA1700', '个', 899.00, 0, '经济型入门主板', NOW()),

-- 内存 (category_id = 3)
('海盗船Corsair DDR5 32GB', 3, '32GB*2 6000MHz', '条', 1299.00, 0, '高速DDR5内存', NOW()),
('金士顿Kingston DDR4 16GB', 3, '16GB*2 3200MHz', '条', 399.00, 0, '稳定可靠DDR4内存', NOW()),
('芝奇G.SKILL DDR5 16GB', 3, '16GB 6000MHz', '条', 599.00, 0, 'RGB炫彩DDR5内存', NOW()),

-- 存储设备 (category_id = 4)
('三星970 EVO Plus 1TB', 4, 'NVMe 1TB', '块', 699.00, 0, '高速NVMe SSD', NOW()),
('西部数据WD Black 2TB', 4, '2.5寸HDD 2TB', '块', 399.00, 0, '大容量机械硬盘', NOW()),
('克鲁格Kingston A3000 512GB', 4, 'NVMe 512GB', '块', 299.00, 0, '平价高速SSD', NOW()),

-- 显卡 (category_id = 5)
('NVIDIA GeForce RTX 4090', 5, '24GB GDDR6X', '块', 11999.00, 0, '旗舰级游戏显卡', NOW()),
('AMD Radeon RX 7900 XTX', 5, '24GB GDDR6', '块', 5999.00, 0, '高端渲染显卡', NOW()),
('NVIDIA GeForce RTX 4070', 5, '12GB GDDR6', '块', 4999.00, 0, '中端游戏显卡', NOW()),

-- 电源 (category_id = 6)
('海盗船RM1000x 1000W', 6, '1000W 80Plus Gold', '台', 1299.00, 0, '模组化电源，效能高', NOW()),
('振华650W金牌电源', 6, '650W 80Plus Gold', '台', 599.00, 0, '稳定可靠的电源', NOW()),
('微星MPG A850G 850W', 6, '850W 80Plus Gold', '台', 899.00, 0, '高效率电源', NOW()),

-- 冷却散热 (category_id = 7)
('海盗船H150i Elite 360', 7, '360mm一体式水冷', '套', 999.00, 0, '液体冷却散热器', NOW()),
('猫头鹰NH-D15', 7, '双塔风冷散热', '套', 699.00, 0, '专业空气冷却器', NOW()),
('NZXT Kraken X73', 7, '360mm AIO水冷', '套', 1099.00, 0, '高效液冷散热方案', NOW()),

-- 外设配件 (category_id = 8)
('罗技G Pro X Superlight', 8, '无线竞技鼠标', '个', 899.00, 0, '职业电竞鼠标', NOW()),
('CORSAIR K95 Platinum', 8, '机械键盘', '个', 1299.00, 0, '高端游戏键盘', NOW()),
('雷蛇DeathAdder V3', 8, '有线游戏鼠标', '个', 599.00, 0, '轻量化游戏鼠标', NOW());

-- ========== 插入电脑配件入库记录 ==========
INSERT INTO computer_part_stockin (computer_part_id, quantity, remark, created_at) VALUES
-- 第一批采购
(1, 50, '供应商采购 - Intel Core i9-13900K', NOW()),
(2, 30, '供应商采购 - AMD Ryzen 9 7900X', NOW()),
(3, 40, '供应商采购 - Intel Core i5-13600K', NOW()),
(4, 20, '供应商采购 - 华硕ROG STRIX Z790', NOW()),
(5, 15, '供应商采购 - 微星MPG B650', NOW()),
(6, 25, '供应商采购 - 技嘉B660M', NOW()),
(7, 60, '供应商采购 - 海盗船Corsair DDR5 32GB', NOW()),
(8, 40, '供应商采购 - 金士顿Kingston DDR4 16GB', NOW()),
(9, 35, '供应商采购 - 芝奇G.SKILL DDR5 16GB', NOW()),
(10, 30, '供应商采购 - 三星970 EVO Plus 1TB', NOW()),

-- 第二批补货
(11, 20, '补货采购 - 西部数据WD Black 2TB', NOW()),
(12, 15, '补货采购 - 克鲁格Kingston A3000 512GB', NOW()),
(13, 10, '补货采购 - NVIDIA GeForce RTX 4090', NOW()),
(14, 18, '补货采购 - AMD Radeon RX 7900 XTX', NOW()),
(15, 12, '补货采购 - NVIDIA GeForce RTX 4070', NOW()),
(16, 100, '大量采购 - 海盗船RM1000x 1000W', NOW()),
(17, 50, '大量采购 - 振华650W金牌电源', NOW()),
(18, 30, '大量采购 - 微星MPG A850G 850W', NOW()),
(19, 25, '大量采购 - 海盗船H150i Elite 360', NOW()),
(20, 20, '大量采购 - 猫头鹰NH-D15', NOW()),

-- 第三批补充
(21, 15, '补充库存 - NZXT Kraken X73', NOW()),
(22, 30, '补充库存 - 罗技G Pro X Superlight', NOW()),
(23, 20, '补充库存 - CORSAIR K95 Platinum', NOW()),
(24, 18, '补充库存 - 雷蛇DeathAdder V3', NOW()),
(1, 30, '紧急采购 - Intel Core i9-13900K', NOW()),
(2, 25, '紧急采购 - AMD Ryzen 9 7900X', NOW());

-- ========== 插入电脑配件出库记录 ==========
INSERT INTO computer_part_stockout (computer_part_id, quantity, remark, created_at) VALUES
-- 零售销售
(1, 5, '零售销售 - Intel Core i9-13900K', NOW()),
(2, 3, '零售销售 - AMD Ryzen 9 7900X', NOW()),
(3, 4, '零售销售 - Intel Core i5-13600K', NOW()),
(7, 10, '零售销售 - 海盗船Corsair DDR5 32GB', NOW()),
(9, 8, '零售销售 - 芝奇G.SKILL DDR5 16GB', NOW()),

-- 企业采购
(4, 2, '企业采购 - 华硕ROG STRIX Z790', NOW()),
(5, 2, '企业采购 - 微星MPG B650', NOW()),
(6, 3, '企业采购 - 技嘉B660M', NOW()),
(8, 6, '企业采购 - 金士顿Kingston DDR4 16GB', NOW()),
(10, 4, '企业采购 - 三星970 EVO Plus 1TB', NOW()),

-- 渠道销售
(11, 3, '渠道销售 - 西部数据WD Black 2TB', NOW()),
(12, 4, '渠道销售 - 克鲁格Kingston A3000 512GB', NOW()),
(13, 1, '渠道销售 - NVIDIA GeForce RTX 4090', NOW()),
(14, 2, '渠道销售 - AMD Radeon RX 7900 XTX', NOW()),
(15, 2, '渠道销售 - NVIDIA GeForce RTX 4070', NOW()),

-- 展销会
(16, 20, '展销会 - 海盗船RM1000x 1000W', NOW()),
(17, 10, '展销会 - 振华650W金牌电源', NOW()),
(18, 8, '展销会 - 微星MPG A850G 850W', NOW()),
(19, 5, '展销会 - 海盗船H150i Elite 360', NOW()),
(20, 4, '展销会 - 猫头鹰NH-D15', NOW()),

-- 网络销售
(21, 6, '网络销售 - NZXT Kraken X73', NOW()),
(22, 10, '网络销售 - 罗技G Pro X Superlight', NOW()),
(23, 8, '网络销售 - CORSAIR K95 Platinum', NOW()),
(24, 7, '网络销售 - 雷蛇DeathAdder V3', NOW()),

-- 返厂维修
(1, 2, '返厂维修 - Intel Core i9-13900K', NOW()),
(2, 2, '返厂维修 - AMD Ryzen 9 7900X', NOW()),
(7, 5, '返厂维修 - 海盗船Corsair DDR5 32GB', NOW()),
(13, 1, '返厂维修 - NVIDIA GeForce RTX 4090', NOW());

-- ========== 验证数据导入 ==========
SELECT '=== 分类统计 ===' as info;
SELECT COUNT(*) as 分类总数 FROM computer_part_category;

SELECT '=== 配件统计 ===' as info;
SELECT COUNT(*) as 配件总数 FROM computer_part;

SELECT '=== 入库记录统计 ===' as info;
SELECT COUNT(*) as 入库总数 FROM computer_part_stockin;

SELECT '=== 出库记录统计 ===' as info;
SELECT COUNT(*) as 出库总数 FROM computer_part_stockout;

SELECT '=== 配件库存明细 ===' as info;
SELECT 
  cpc.name as 配件分类,
  cp.name as 配件名称,
  cp.specification as 规格,
  cp.unit as 单位,
  cp.price as 价格,
  (COALESCE((SELECT SUM(quantity) FROM computer_part_stockin WHERE computer_part_id = cp.id), 0) - 
   COALESCE((SELECT SUM(quantity) FROM computer_part_stockout WHERE computer_part_id = cp.id), 0)) as 当前库存
FROM computer_part cp
LEFT JOIN computer_part_category cpc ON cp.category_id = cpc.id
ORDER BY cpc.id, cp.id;

-- ========== 更新配件库存 ==========
UPDATE computer_part cp
SET stock = COALESCE((SELECT SUM(quantity) FROM computer_part_stockin WHERE computer_part_id = cp.id), 0) - 
           COALESCE((SELECT SUM(quantity) FROM computer_part_stockout WHERE computer_part_id = cp.id), 0);

SELECT '=== 更新后的配件库存 ===' as info;
SELECT cp.name, cp.stock FROM computer_part cp ORDER BY cp.id;
