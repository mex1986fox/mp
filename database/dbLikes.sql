CREATE DATABASE likes WITH 
    ENCODING='UTF8' 
    TEMPLATE = template0;
CREATE USER drovito WITH password 'drovito';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "drovito";
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO "drovito";

create table "ads"(
    ads_id bigint UNIQUE,
    likes integer,
    dislikes integer,
    users integer[],
    PRIMARY KEY (ads_id)
);