-- User table to store user information

create table users (
    user_id serial primary key,
    name varchar(255) not null,
    email varchar(255) not null unique,
    password varchar(255) not null,
    role varchar(50) not null,
    created_at timestamp default current_timestamp
);



-- Product table to store product information

create table products (
    product_id serial primary key,
    name varchar(255) not null,
    description text,
    category varchar(255) not null,
    price decimal(10, 2) not null check (price > 0),
    stock int not null check (stock >= 0),
    modified_at timestamp default current_timestamp
);



-- Orders table to store order information

create table orders (
    order_id serial primary key,
    user_id int not null references users(user_id) on delete no action,
    total_amount decimal(10, 2) not null check (total_amount >= 0),
    status varchar(50) not null,
    order_date timestamp default current_timestamp
);



-- Order items table to store details of products in each order(This table maintains the 3NF by separating the order details from the orders table, allowing for multiple products per order and ensuring data integrity)

create table order_items (
    order_item_id serial primary key,
    order_id int not null references orders(order_id) on delete cascade,
    product_id int not null references products(product_id) on delete no action,
    quantity int not null check (quantity > 0),
    unit_price decimal(10, 2) not null check (unit_price >= 0)
);



-- Payments table to store payment information for orders

create table payments (
    payment_id serial primary key,
    order_id int references orders(order_id) on delete set null,
    amount decimal(10, 2) not null check (amount >= 0),
    payment_date timestamp default current_timestamp,
    payment_method varchar(50) not null
);

