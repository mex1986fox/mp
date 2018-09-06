CREATE DATABASE drovito WITH 
    ENCODING='UTF8' 
    TEMPLATE = template0;
CREATE USER drovito WITH password 'drovito';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "drovito";
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO "drovito";
-- таблица пользователей
CREATE TABLE "users" (
    id serial,
    LOGIN varchar(64) NOT NULL UNIQUE,
    PASSWORD varchar(32) NOT NULL,
    recovery_key varchar(32) NOT NULL, -- ключ для восстановления пароля захеширован MD5
    name varchar(64) NOT NULL,
    surname varchar(64),
    birthdate date,
    PRIMARY KEY (id)
);
