create table customer (
    customer_id integer primary key,
    name text,
    email text unique,
    phone text
);

create table category (
    category_id integer primary key,
    category_name text unique
);

create table product (
    product_id integer primary key,
    name text,
    category_id integer,
    price numeric,
    foreign key (category_id) references category(category_id)
);

create table orders (
    order_id integer primary key,
    customer_id integer,
    order_date date,
    status text,
    foreign key (customer_id) references customer(customer_id)
);

create table order_item (
    order_id integer,
    product_id integer,
    quantity integer,
    primary key (order_id, product_id),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references product(product_id)
);

create table payment (
    payment_id integer primary key,
    order_id integer,
    amount numeric,
    payment_method text,
    payment_date date,
    foreign key (order_id) references orders(order_id)
);


insert into customer values (1, 'ravi', 'ravi@mail.com', '9876543210');
insert into customer values (2, 'anu', 'anu@mail.com', '8888888888');

insert into category values (1, 'electronics');
insert into category values (2, 'clothing');

insert into product values (101, 'laptop', 1, 50000);
insert into product values (102, 't-shirt', 2, 1000);
insert into product values (103, 'headphones', 1, 2000);

insert into orders values (1, 1, '2026-04-25', 'placed');
insert into orders values (2, 2, '2026-04-26', 'shipped');

insert into order_item values (1, 101, 1);
insert into order_item values (1, 103, 2);
insert into order_item values (2, 102, 3);

insert into payment values (1, 1, 54000, 'upi', '2026-04-25');
insert into payment values (2, 2, 3000, 'card', '2026-04-26');

select c.name, o.order_id, o.status
from customer c
join orders o on c.customer_id = o.customer_id;

select o.order_id, p.name, oi.quantity
from orders o
join order_item oi on o.order_id = oi.order_id
join product p on oi.product_id = p.product_id;
