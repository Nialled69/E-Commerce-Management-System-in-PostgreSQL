-- Trigger to update product stock after an order item is inserted

CREATE OR REPLACE FUNCTION update_product_stock()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_update_stock
AFTER INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION update_product_stock();





-- Trigger to update the modified_at timestamp in products table on update


CREATE OR REPLACE FUNCTION update_product_recent_modification()
RETURNS TRIGGER AS $$
BEGIN
    NEW.modified_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_products_modified
BEFORE UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION update_product_recent_modification();

