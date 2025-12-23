电脑配件销售系统

一个完整的电脑配件销售管理平台，包括前端Vue 3和后端Spring Boot，支持登录、注册、配件分类管理、配件信息管理等功能。

项目结构

```
computer-part-sales-system/
├── frontend/               # Vue 3前端项目
│   ├── src/
│   │   ├── api/           # API接口
│   │   ├── views/         # 页面组件
│   │   ├── router/        # 路由配置
│   │   ├── store/         # 状态管理
│   │   └── main.js        # 入口文件
│   └── package.json
└── backend/               # Spring Boot后端项目
    ├── src/
    │   ├── java/com/computerpart/
    │   │   ├── controller/    # 控制器
    │   │   ├── service/       # 业务逻辑
    │   │   ├── entity/        # 数据实体
    │   │   ├── repository/    # 数据访问
    │   │   ├── dto/           # 数据传输对象
    │   │   ├── util/          # 工具类
    │   │   ├── config/        # 配置类
    │   │   └── security/      # 安全配置
    │   └── resources/
    │       └── application.yml # 配置文件
    └── pom.xml
```

功能模块

 已实现功能
- ✅ 用户登录、注册、退出
- ✅ JWT令牌认证
- ✅ 角色权限管理（管理员/客户）
- ✅ 配件分类管理（增删改查）
- ✅ 配件信息管理（增删改查、分页、搜索）
- ✅ 配件入库管理（自动更新库存）
- ✅ 配件出库管理（自动扣减库存）
- ✅ 客户购物车和订单系统
- ✅ 管理员订单管理
- ✅ 前后端分离架构
- ✅ 跨域请求处理
- ✅ 统一API响应格式

**库存管理机制**
- 📦 配件初始库存为 **0**
- ➕ 通过 **入库操作** 增加库存：`库存 = 库存 + 入库数量`
- ➖ 通过 **出库操作** 减少库存：`库存 = 库存 - 出库数量`
- 🛒 客户下单后自动创建出库记录并扣减库存

可扩展功能
- 🔲 库存统计与预警
- 🔲 操作日志记录
- 🔲 数据导入导出
- 🔲 生成销售报表

 技术栈

前端
- Vue 3
- Vite (构建工具)
- Vue Router (路由)
- Pinia (状态管理)
- Element Plus (UI组件库)
- Axios (HTTP请求)
- SCSS

# 后端
- Spring Boot 3.1.0
- Spring Security (认证授权)
- Spring Data JPA (数据访问)
- JWT (令牌认证)
- MySQL 8.0 (数据库)
- Maven (构建工具)

快速开始

前置要求
- Node.js >= 16.0
- Java JDK >= 17
- Maven >= 3.8.0
- MySQL 8.0+

后端启动

1. 创建数据库并初始化
```sql
CREATE DATABASE computer_part_management DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;
```
导入数据库初始化脚本 `complete_data_init.sql`

2. 配置数据库连接
编辑 `backend/src/main/resources/application.yml`：
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/computer_part_management?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC
    username: root
    password: 123456
```

3. 运行Spring Boot应用
```bash
cd backend
mvn clean install
mvn spring-boot:run
```

应用将在 `http://localhost:8080` 启动。

前端启动

1. 安装依赖
```bash
cd frontend
npm install
```

2. 启动开发服务器
```bash
npm run dev
```
应用将在 `http://localhost:5173` 启动。

## 使用说明

### 默认账户
系统初始化后提供以下测试账户：

| 账户类型 | 用户名 | 密码 | 权限说明 |
|---------|--------|------|---------|
| 管理员 | admin | 123456 | 完整的系统管理权限 |
| 客户 | customer | 123456 | 浏览商品、下单购买 |
| 测试客户 | testuser | 123456 | 浏览商品、下单购买 |

### 库存管理流程

**重要：** 配件的初始库存为 **0**，所有库存变化都通过入库和出库操作来管理。

1. **配件入库**（管理员操作）
   - 导航至 `配件入库` 页面
   - 选择配件、填写入库数量和备注
   - 点击保存，系统自动增加该配件的库存

2. **配件出库**（管理员操作）
   - 导航至 `配件出库` 页面
   - 选择配件、填写出库数量和备注
   - 点击保存，系统自动减少该配件的库存

3. **客户购买**（自动出库）
   - 客户在商城浏览配件，加入购物车
   - 提交订单后，系统自动创建出库记录
   - 库存相应减少

### 主要功能模块

**管理员功能：**
- 📦 配件管理：新增、编辑、删除配件信息
- 📁 分类管理：管理配件分类
- 📥 入库管理：记录配件入库，增加库存
- 📤 出库管理：记录配件出库，减少库存
- 📋 订单管理：查看所有客户订单，更新订单状态

**客户功能：**
- 🛍️ 商品浏览：查看所有在售配件
- 🛒 购物车：添加商品到购物车
- 💳 下单购买：提交订单完成购买
- 📦 我的订单：查看个人订单历史

