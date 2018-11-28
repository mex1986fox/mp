CREATE DATABASE photos_albums WITH 
    ENCODING='UTF8' 
    TEMPLATE = template0;
CREATE USER drovito WITH password 'drovito';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "drovito";
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO "drovito";

create table "lincks"(
    albums_id bigint UNIQUE,
    lincks jsonb,
    PRIMARY KEY (albums_id)
);