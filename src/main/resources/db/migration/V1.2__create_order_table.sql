CREATE
SEQUENCE IF NOT EXISTS local_lib.orders_seq START
WITH 1 INCREMENT BY 1;

CREATE TABLE IF NOT EXISTS local_lib.orders
(
    id              bigint    default nextval('local_lib.orders_seq'),
    user_id         bigint                 NOT NULL,
    book_id         bigint                 NOT NULL,
    start_date      timestamp              NOT NULL,
    end_date        timestamp              NOT NULL,
    return_date     timestamp DEFAULT NULL,
    on_subscription boolean   DEFAULT TRUE NOT NULL,

    CONSTRAINT PK_Orders_id PRIMARY KEY (id),
    CONSTRAINT FK_users_in_orders_id FOREIGN KEY (user_id) REFERENCES user_data.users (id),
    CONSTRAINT FK_books_in_orders_id FOREIGN KEY (book_id) REFERENCES local_lib.books (id)
);