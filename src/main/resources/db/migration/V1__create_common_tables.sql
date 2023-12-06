CREATE SCHEMA IF NOT EXISTS local_lib;
SET datestyle = 'ISO, DMY';

CREATE SEQUENCE IF NOT EXISTS local_lib.genres_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS local_lib.genres
(
    id    bigint default nextval('local_lib.genres_seq'),
    title varchar(50) NOT NULL,

    CONSTRAINT PK_genres PRIMARY KEY (id)
);


CREATE SEQUENCE IF NOT EXISTS local_lib.publishers_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS local_lib.publishers
(
    id    bigint default nextval('local_lib.publishers_seq'),
    title varchar(250),

    CONSTRAINT PK_Publishers PRIMARY KEY (id)
);


CREATE SEQUENCE IF NOT EXISTS local_lib.authors_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS local_lib.authors
(
    id         bigint default nextval('local_lib.authors_seq'),
    first_name varchar(50) NOT NULL,
    last_name  varchar(50) NOT NULL,

    CONSTRAINT PK_Authors PRIMARY KEY (id),
    CONSTRAINT UQ_Authors_names UNIQUE (first_name, last_name)
);

CREATE SEQUENCE IF NOT EXISTS local_lib.books_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS local_lib.books
(
    id               bigint  default nextval('local_lib.books_seq'),
    title            varchar(350)          NOT NULL,
    publisher_id     bigint                NOT NULL,
    genre_id         bigint                NOT NULL,
    author_id        bigint                NOT NULL,
    pages            int                   NOT NULL,
    publication_date date                  NOT NULL,
    copies           int                   NOT NULL,
    removed          boolean DEFAULT FALSE NOT NULL,

    CONSTRAINT PK_books_id PRIMARY KEY (id),
    CONSTRAINT FK_books_publisher_id FOREIGN KEY (publisher_id) REFERENCES local_lib.publishers (id),
    CONSTRAINT FK_books_genre_id FOREIGN KEY (genre_id) REFERENCES local_lib.genres (id),
    CONSTRAINT FK_books_author_id FOREIGN KEY (author_id) REFERENCES local_lib.authors (id),
    CONSTRAINT UQ_books UNIQUE (title, publisher_id, genre_id, author_id, pages, publication_date)
);



CREATE SEQUENCE IF NOT EXISTS local_lib.roles_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS local_lib.roles
(
    id    bigint default nextval('local_lib.roles_seq'),
    title varchar(100) NOT NULL,

    CONSTRAINT PK_Roles PRIMARY KEY (id),
    CONSTRAINT UQ_Roles_title UNIQUE (title)
);

CREATE SEQUENCE IF NOT EXISTS local_lib.user_status_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS local_lib.user_statuses
(
    id    bigint default nextval('local_lib.user_status_seq'),
    title varchar(30) NOT NULL,

    CONSTRAINT PK_User_statuses PRIMARY KEY (id),
    CONSTRAINT UQ_User_statuses_title UNIQUE (title)
);

CREATE SEQUENCE IF NOT EXISTS local_lib.users_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS local_lib.users
(
    id           bigint default nextval('local_lib.users_seq'),
    login        varchar(100) NOT NULL,
    password     varchar(130) NOT NULL,
    role_id      bigint       NOT NULL,
    status_id    bigint       NOT NULL,
    email        varchar(250) NOT NULL,
    phone_number varchar(25),
    first_name   varchar(50)  NOT NULL,
    second_name  varchar(50)  NOT NULL,

    CONSTRAINT PK_users PRIMARY KEY (id),
    CONSTRAINT FK_users_Role FOREIGN KEY (role_id) REFERENCES local_lib.roles (id),
    CONSTRAINT FK_users_Status FOREIGN KEY (status_id) REFERENCES local_lib.user_statuses (id),
    CONSTRAINT UQ_users_login UNIQUE (login),
    CONSTRAINT UQ_users_Email UNIQUE (email)
);

CREATE UNIQUE INDEX UQ_phone_number_ind
    ON local_lib.users (phone_number)
    WHERE phone_number IS NOT NULL;


CREATE SEQUENCE IF NOT EXISTS local_lib.orders_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS local_lib.orders
(
    id               bigint    default nextval('local_lib.orders_seq'),
    user_id          bigint                 NOT NULL,
    book_id          bigint                 NOT NULL,
    order_start_date timestamp              NOT NULL,
    order_end_date   timestamp              NOT NULL,
    return_date      timestamp DEFAULT NULL,
    on_subscription  boolean   DEFAULT TRUE NOT NULL,

    CONSTRAINT PK_Orders_id PRIMARY KEY (id),
    CONSTRAINT FK_users_in_orders_id FOREIGN KEY (user_id) REFERENCES local_lib.users (id),
    CONSTRAINT FK_books_in_orders_id FOREIGN KEY (book_id) REFERENCES local_lib.books (id)
);