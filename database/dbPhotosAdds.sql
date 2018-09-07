CREATE DATABASE photos_ads WITH 
    ENCODING='UTF8' 
    TEMPLATE = template0;
CREATE USER drovito WITH password 'drovito';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "drovito";
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO "drovito";

create table "lincks"(
    ads_id bigint UNIQUE,
    lincks jsonb,
    PRIMARY KEY (ads_id)
);