# E-Commerce Order Management System

## Project Overview
This project is a relational database system designed to manage core e-commerce operations, including user management, product inventory, order processing, and payment tracking. It is implemented using **PL/pgSQL** to ensure data integrity and automate business logic through triggers and stored procedures.

## Database Schema
The system uses a normalized schema consisting of five primary tables:
* **Users**: Stores profile information and roles (e.g., customer or admin).
* **Products**: Maintains the catalog, including descriptions, categories, pricing, and stock levels.
* **Orders**: Tracks the high-level status and total amount of customer purchases.
* **Order_Items**: A bridge table linking products to orders, supporting multiple items per transaction and ensuring 3NF.
* **Payments**: Records financial transactions related to orders.

## Key Features & Automation
The system automates critical business logic directly within the database layer:

### 1. Inventory Management (Triggers)
* **Stock Auto-Update**: An `AFTER INSERT` trigger on `order_items` automatically deducts purchased quantities from the `products` table.
* **Audit Trail**: A `BEFORE UPDATE` trigger on `products` ensures the `modified_at` timestamp is updated whenever a product is edited.

### 2. Order Processing (Stored Procedures)
* **Transaction Control**: The `place_order` procedure handles the checkout workflow, performing stock availability checks before committing a new order.
* **Dynamic Pricing**: A helper function, `product_price_fetch`, retrieves the current item price during the order process to ensure billing accuracy.

### 3. Performance Optimization
* **Full-Text Search**: GIN indexes are implemented on product names and descriptions for rapid keyword searching.
* **Foreign Key Indexing**: Optimized indexes on user and product IDs to speed up table joins.
* **Composite Indexes**: Multi-column indexes (e.g., `user_id` and `status`) optimize frequent customer dashboard queries.

## Analytics & Reporting
The system includes a **View** called `sales_report` that aggregates sales data to show total units sold and total revenue generated per product.

## Getting Started
1. **Initialize**: Run `initiation.sql` to create the database.
2. **Schema**: Execute `schema.sql` to build the tables and constraints.
3. **Logic**: Load `triggers.sql`, `transaction.sql`, and `view.sql`.
4. **Data Seeding**: Run `automated_population.sql` to generate test users and products using automated loops.
5. **Execution**: Use `Exec.sql` to simulate a purchase transaction.
