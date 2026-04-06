create procedure populate_automated_data()
language plpgsql
as $$
declare 
    i integer := 1;
begin
    while i <= 20 loop
        insert into users(name, email, password, role) values (
            'User ' || i+4,
            'user' || i+4 || '@example.com',
            'password' ||'@' || i+4,
            'customer'
        );
        i := i + 1;
    end loop;
end;
$$;


create procedure populate_products()
language plpgsql
as $$
declare
    j integer := 1;
begin
    while j <= 5 loop
        insert into products(name, description, category, price, stock) values (
                'Item ' || j,
                'Description for Item: fdssbhyfhcbjkdbchjbaewbjeuithuiewf' || j,
                'Miscellaneous',
                floor(random() * 99901) + 100,
                floor(random() * 50) + 1
            );
        j := j + 1;
    end loop;
end;
$$;

call populate_products();

call populate_automated_data();


select * from users limit 10;

select * from products;