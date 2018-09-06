CREATE DATABASE photos_ads WITH 
    ENCODING='UTF8' 
    TEMPLATE = template0;
CREATE USER drovito WITH password 'drovito';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "drovito";
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO "drovito";

CREATE TABLE "users" (
    id bigserial,
    session varchar(42) NULL,
    lifetime timestamp,
    PRIMARY KEY (id)
);

create table "ads"(
    id bigserial,
    user_id bigint,
    lincks jsonb,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);