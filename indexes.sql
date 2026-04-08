-- Full-Text Search Indexes for product name and description
CREATE INDEX idx_products_fulltext ON products
USING GIN (to_tsvector('english', coalesce(name, '') || ' ' || coalesce(description, '')));

CREATE INDEX idx_products_name_tsv ON products
USING GIN (to_tsvector('english', name));

CREATE INDEX idx_products_description_tsv ON products
USING GIN (to_tsvector('english', description));




-- FOREIGN KEY INDEXES (used for joins)
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
CREATE INDEX idx_payments_order_id ON payments(order_id);



-- INDEXES for filtering and searching
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_products_stock ON products(stock);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_order_date ON orders(order_date);



-- COMPOSITE INDEXES (for common query patterns) (when order status of a specific user is frequently queried)
CREATE INDEX idx_orders_user_status ON orders(user_id, status);
