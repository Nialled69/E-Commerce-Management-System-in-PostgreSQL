create table users (
    user_id serial primary key,
    name varchar(255) not null,
    email varchar(255) not null unique,
    password varchar(255) not null,
    role varchar(50) not null,
    created_at timestamp default current_timestamp
);

create table products (
    product_id serial primary key,
    name varchar(255) not null,
    description text,
    category varchar(255) not null,
    price decimal(10, 2) not null check (price > 0),
    stock int not null check (stock >= 0),
    modified_at timestamp default current_timestamp
);

create table orders (
    order_id serial primary key,
    user_id int not null references users(user_id) on delete no action,
    total_amount decimal(10, 2) not null check (total_amount >= 0),
    status varchar(50) not null,
    order_date timestamp default current_timestamp
);

create table order_items (
    order_item_id serial primary key,
    order_id int not null references orders(order_id) on delete cascade,
    product_id int not null references products(product_id) on delete no action,
    quantity int not null check (quantity > 0),
    unit_price decimal(10, 2) not null check (unit_price >= 0)
);

create table payments (
    payment_id serial primary key,
    order_id int references orders(order_id) on delete set null,
    amount decimal(10, 2) not null check (amount >= 0),
    payment_date timestamp default current_timestamp,
    payment_method varchar(50) not null
);

