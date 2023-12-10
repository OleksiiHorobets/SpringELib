CREATE SCHEMA IF NOT EXISTS local_lib;

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

