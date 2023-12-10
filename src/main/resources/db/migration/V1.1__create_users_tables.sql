CREATE SCHEMA IF NOT EXISTS user_data;

CREATE SEQUENCE IF NOT EXISTS user_data.roles_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS user_data.roles
(
    id    bigint default nextval('user_data.roles_seq'),
    title varchar(100) NOT NULL,

    CONSTRAINT PK_Roles PRIMARY KEY (id),
    CONSTRAINT UQ_Roles_title UNIQUE (title)
);

CREATE SEQUENCE IF NOT EXISTS user_data.users_seq START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS user_data.users
(
    id           bigint                default nextval('user_data.users_seq'),
    username     varchar(100) NOT NULL,
    password     varchar(130) NOT NULL,
    role_id      bigint       NOT NULL,
    is_banned    boolean      NOT NULL default false,
    email        varchar(250) NOT NULL,
    phone_number varchar(25),
    first_name   varchar(50)  NOT NULL,
    last_name  varchar(50)  NOT NULL,

    CONSTRAINT PK_users PRIMARY KEY (id),
    CONSTRAINT FK_users_role FOREIGN KEY (role_id) REFERENCES user_data.roles (id),
    CONSTRAINT UQ_users_username UNIQUE (username),
    CONSTRAINT UQ_users_email UNIQUE (email)
);

CREATE UNIQUE INDEX UQ_phone_number_ind
    ON user_data.users (phone_number)
    WHERE phone_number IS NOT NULL;

