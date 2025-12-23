-- 电脑配件销售系统完整数据库初始化脚本

-- ========== 创建数据库 ==========
DROP DATABASE IF EXISTS computer_part_management;
CREATE DATABASE IF NOT EXISTS computer_part_management DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE computer_part_management;

-- ========== 创建用户表 ==========
CREATE TABLE user (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  email VARCHAR(100),
  role VARCHAR(20) NOT NULL DEFAULT 'CUSTOMER' COMMENT 'ADMIN-管理员, CUSTOMER-客户',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ========== 创建电脑配件分类表 ==========
CREATE TABLE computer_part_category (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  description VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ========== 创建电脑配件表 ==========
CREATE TABLE computer_part (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  category_id BIGINT NOT NULL,
  specification VARCHAR(100),
  unit VARCHAR(20),
  price DECIMAL(10, 2),
  stock BIGINT DEFAULT 0,
  description VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES computer_part_category(id),
  INDEX idx_category (category_id),
  INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ========== 创建电脑配件入库表 ==========
CREATE TABLE computer_part_stockin (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  computer_part_id BIGINT NOT NULL,
  quantity BIGINT NOT NULL,
  remark VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (computer_part_id) REFERENCES computer_part(id),
  INDEX idx_computer_part (computer_part_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ========== 创建电脑配件出库表 ==========
CREATE TABLE computer_part_stockout (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  computer_part_id BIGINT NOT NULL,
  quantity BIGINT NOT NULL,
  remark VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (computer_part_id) REFERENCES computer_part(id),
  INDEX idx_computer_part (computer_part_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ========== 创建订单表 ==========
CREATE TABLE `order` (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_number VARCHAR(50) NOT NULL UNIQUE COMMENT '订单号',
  user_id BIGINT NOT NULL COMMENT '用户ID',
  total_amount DECIMAL(10, 2) NOT NULL COMMENT '订单总金额',
  status VARCHAR(20) NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING-待支付, PAID-已支付, SHIPPED-已发货, COMPLETED-已完成, CANCELLED-已取消',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES user(id),
  INDEX idx_user (user_id),
  INDEX idx_order_number (order_number),
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ========== 创建订单明细表 ==========
CREATE TABLE order_item (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id BIGINT NOT NULL COMMENT '订单ID',
  computer_part_id BIGINT NOT NULL COMMENT '配件ID',
  quantity BIGINT NOT NULL COMMENT '购买数量',
  unit_price DECIMAL(10, 2) NOT NULL COMMENT '单价',
  subtotal DECIMAL(10, 2) NOT NULL COMMENT '小计',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES `order`(id) ON DELETE CASCADE,
  FOREIGN KEY (computer_part_id) REFERENCES computer_part(id),
  INDEX idx_order (order_id),
  INDEX idx_computer_part (computer_part_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ========== 插入初始用户数据 ==========
INSERT INTO user (username, password, email, role) VALUES
('admin', '$2a$10$slYQmyNdGzin7olVN3p5Be7DlH.PKZbv5H8KnzzVgXXbVxzy5QMBK', 'admin@example.com', 'ADMIN'),
('customer', '$2a$10$slYQmyNdGzin7olVN3p5Be7DlH.PKZbv5H8KnzzVgXXbVxzy5QMBK', 'customer@example.com', 'CUSTOMER');

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
INSERT INTO computer_part (name, category_id, specification, unit, price, stock, description) VALUES
-- CPU处理器 (category_id = 1)
('Intel Core i9-13900K', 1, '8核16线程', '个', 4599.00, 0, '高端处理器，适合游戏和工作站'),
('AMD Ryzen 9 7900X', 1, '12核24线程', '个', 3999.00, 0, '高性能多核处理器'),
('Intel Core i5-13600K', 1, '6核12线程', '个', 2299.00, 0, '中端处理器，性价比高'),

-- 主板 (category_id = 2)
('华硕ROG STRIX Z790', 2, 'LGA1700', '个', 2899.00, 0, '旗舰级游戏主板'),
('微星MPG B650', 2, 'AM5', '个', 1899.00, 0, '高性能消费级主板'),
('技嘉B660M', 2, 'LGA1700', '个', 899.00, 0, '经济型入门主板'),

-- 内存 (category_id = 3)
('海盗船Corsair DDR5 32GB', 3, '32GB*2 6000MHz', '条', 1299.00, 0, '高速DDR5内存'),
('金士顿Kingston DDR4 16GB', 3, '16GB*2 3200MHz', '条', 399.00, 0, '稳定可靠DDR4内存'),
('芝奇G.SKILL DDR5 16GB', 3, '16GB 6000MHz', '条', 599.00, 0, 'RGB炫彩DDR5内存'),

-- 存储设备 (category_id = 4)
('三星970 EVO Plus 1TB', 4, 'NVMe 1TB', '块', 699.00, 0, '高速NVMe SSD'),
('西部数据WD Black 2TB', 4, '2.5寸HDD 2TB', '块', 399.00, 0, '大容量机械硬盘'),
('克鲁格Kingston A3000 512GB', 4, 'NVMe 512GB', '块', 299.00, 0, '平价高速SSD'),

-- 显卡 (category_id = 5)
('NVIDIA GeForce RTX 4090', 5, '24GB GDDR6X', '块', 11999.00, 0, '旗舰级游戏显卡'),
('AMD Radeon RX 7900 XTX', 5, '24GB GDDR6', '块', 5999.00, 0, '高端渲染显卡'),
('NVIDIA GeForce RTX 4070', 5, '12GB GDDR6', '块', 4999.00, 0, '中端游戏显卡'),

-- 电源 (category_id = 6)
('海盗船RM1000x 1000W', 6, '1000W 80Plus Gold', '台', 1299.00, 0, '模组化电源，效能高'),
('振华650W金牌电源', 6, '650W 80Plus Gold', '台', 599.00, 0, '稳定可靠的电源'),
('微星MPG A850G 850W', 6, '850W 80Plus Gold', '台', 899.00, 0, '高效率电源'),

-- 冷却散热 (category_id = 7)
('海盗船H150i Elite 360', 7, '360mm一体式水冷', '套', 999.00, 0, '液体冷却散热器'),
('猫头鹰NH-D15', 7, '双塔风冷散热', '套', 699.00, 0, '专业空气冷却器'),
('NZXT Kraken X73', 7, '360mm AIO水冷', '套', 1099.00, 0, '高效液冷散热方案'),

-- 外设配件 (category_id = 8)
('罗技G Pro X Superlight', 8, '无线竞技鼠标', '个', 899.00, 0, '职业电竞鼠标'),
('CORSAIR K95 Platinum', 8, '机械键盘', '个', 1299.00, 0, '高端游戏键盘'),
('雷蛇DeathAdder V3', 8, '有线游戏鼠标', '个', 599.00, 0, '轻量化游戏鼠标');

-- ========== 插入电脑配件入库记录 ==========
INSERT INTO computer_part_stockin (computer_part_id, quantity, remark) VALUES
-- 第一批采购
(1, 50, '供应商采购 - Intel Core i9-13900K'),
(2, 30, '供应商采购 - AMD Ryzen 9 7900X'),
(3, 40, '供应商采购 - Intel Core i5-13600K'),
(4, 20, '供应商采购 - 华硕ROG STRIX Z790'),
(5, 15, '供应商采购 - 微星MPG B650'),
(6, 25, '供应商采购 - 技嘉B660M'),
(7, 60, '供应商采购 - 海盗船Corsair DDR5 32GB'),
(8, 40, '供应商采购 - 金士顿Kingston DDR4 16GB'),
(9, 35, '供应商采购 - 芝奇G.SKILL DDR5 16GB'),
(10, 30, '供应商采购 - 三星970 EVO Plus 1TB'),

-- 第二批补货
(11, 20, '补货采购 - 西部数据WD Black 2TB'),
(12, 15, '补货采购 - 克鲁格Kingston A3000 512GB'),
(13, 10, '补货采购 - NVIDIA GeForce RTX 4090'),
(14, 18, '补货采购 - AMD Radeon RX 7900 XTX'),
(15, 12, '补货采购 - NVIDIA GeForce RTX 4070'),
(16, 100, '大量采购 - 海盗船RM1000x 1000W'),
(17, 50, '大量采购 - 振华650W金牌电源'),
(18, 30, '大量采购 - 微星MPG A850G 850W'),
(19, 25, '大量采购 - 海盗船H150i Elite 360'),
(20, 20, '大量采购 - 猫头鹰NH-D15'),

-- 第三批补充
(21, 15, '补充库存 - NZXT Kraken X73'),
(22, 30, '补充库存 - 罗技G Pro X Superlight'),
(23, 20, '补充库存 - CORSAIR K95 Platinum'),
(24, 18, '补充库存 - 雷蛇DeathAdder V3'),
(1, 30, '紧急采购 - Intel Core i9-13900K'),
(2, 25, '紧急采购 - AMD Ryzen 9 7900X');

-- ========== 插入电脑配件出库记录 ==========
INSERT INTO computer_part_stockout (computer_part_id, quantity, remark) VALUES
-- 零售销售
(1, 5, '零售销售 - Intel Core i9-13900K'),
(2, 3, '零售销售 - AMD Ryzen 9 7900X'),
(3, 4, '零售销售 - Intel Core i5-13600K'),
(7, 10, '零售销售 - 海盗船Corsair DDR5 32GB'),
(9, 8, '零售销售 - 芝奇G.SKILL DDR5 16GB'),

-- 企业采购
(4, 2, '企业采购 - 华硕ROG STRIX Z790'),
(5, 2, '企业采购 - 微星MPG B650'),
(6, 3, '企业采购 - 技嘉B660M'),
(8, 6, '企业采购 - 金士顿Kingston DDR4 16GB'),
(10, 4, '企业采购 - 三星970 EVO Plus 1TB'),

-- 渠道销售
(11, 3, '渠道销售 - 西部数据WD Black 2TB'),
(12, 4, '渠道销售 - 克鲁格Kingston A3000 512GB'),
(13, 1, '渠道销售 - NVIDIA GeForce RTX 4090'),
(14, 2, '渠道销售 - AMD Radeon RX 7900 XTX'),
(15, 2, '渠道销售 - NVIDIA GeForce RTX 4070'),

-- 展销会
(16, 20, '展销会 - 海盗船RM1000x 1000W'),
(17, 10, '展销会 - 振华650W金牌电源'),
(18, 8, '展销会 - 微星MPG A850G 850W'),
(19, 5, '展销会 - 海盗船H150i Elite 360'),
(20, 4, '展销会 - 猫头鹰NH-D15'),

-- 网络销售
(21, 6, '网络销售 - NZXT Kraken X73'),
(22, 10, '网络销售 - 罗技G Pro X Superlight'),
(23, 8, '网络销售 - CORSAIR K95 Platinum'),
(24, 7, '网络销售 - 雷蛇DeathAdder V3'),

-- 返厂维修
(1, 2, '返厂维修 - Intel Core i9-13900K'),
(2, 2, '返厂维修 - AMD Ryzen 9 7900X'),
(7, 5, '返厂维修 - 海盗船Corsair DDR5 32GB'),
(13, 1, '返厂维修 - NVIDIA GeForce RTX 4090');

-- ========== 验证数据导入 ==========
SELECT '=== 数据库初始化完成 ===' as info;
SELECT '分类总数:' as info, COUNT(*) as 数量 FROM computer_part_category;
SELECT '配件总数:' as info, COUNT(*) as 数量 FROM computer_part;
SELECT '入库记录总数:' as info, COUNT(*) as 数量 FROM computer_part_stockin;
SELECT '出库记录总数:' as info, COUNT(*) as 数量 FROM computer_part_stockout;

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
