-- Transaction procedure to place a order 

CREATE OR REPLACE PROCEDURE place_order(
    p_user_id INT,
    p_product_id INT,
    p_qty INT,
    p_price DECIMAL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_order_id INT;
    v_stock INT;

BEGIN
    -- Stock availability check
    SELECT stock INTO v_stock FROM products WHERE product_id = p_product_id;
    
    IF v_stock IS NULL THEN
        RAISE EXCEPTION 'Product with ID % not found', p_product_id;
    END IF;
    
    IF v_stock < p_qty THEN
        RAISE EXCEPTION 'Insufficient stock for product ID %. Available: %, Requested: %', p_product_id, v_stock, p_qty;
    END IF;


    -- Consequent order table entry
    INSERT INTO orders (user_id, total_amount, status)
    VALUES (p_user_id, (p_qty * p_price), 'Pending')
    RETURNING order_id INTO v_order_id;

    -- Inserting the Order Items for the corresponding order
    INSERT INTO order_items (order_id, product_id, quantity, unit_price)
    VALUES (v_order_id, p_product_id, p_qty, p_price);

END;
$$;



-- Function to fetch product price based on product ID (will call this function in the above procedure call)

create or replace function product_price_fetch(p_product_id INT)
returns DECIMAL
LANGUAGE plpgsql
AS $$ 
DECLARE
    p_price DECIMAL;
BEGIN
    SELECT price INTO p_price FROM products WHERE product_id = p_product_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Product with ID % not found', p_product_id;
    END IF;

    return p_price;
END;
$$;
