
CREATE DATABASE albums WITH 
    ENCODING='UTF8' 
    TEMPLATE = template0;
CREATE USER drovito WITH password 'drovito';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "drovito";
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO "drovito";

CREATE TABLE "albums" (
    id bigserial,
    user_id bigint NOT NULL,
    settlements_id smallint,
    subjects_id smallint,
    countries_id smallint,
    model_id smallint,
    brand_id smallint,
    transport_id smallint,
    year smallint,
    name text,
    date_create timestamp default current_timestamp,
    PRIMARY KEY (id),
    FOREIGN KEY (settlements_id) REFERENCES locations_settlements(id),
    FOREIGN KEY (subjects_id) REFERENCES locations_subjects(id),
    FOREIGN KEY (countries_id) REFERENCES locations_countries(id),
    FOREIGN KEY (model_id) REFERENCES transports_models(id),
    FOREIGN KEY (brand_id) REFERENCES transports_brands(id),
    FOREIGN KEY (transport_id) REFERENCES transports(id)
);

CREATE TABLE "lincks" (
    albums_id bigint NOT NULL,
    lincks jsonb,
    FOREIGN KEY (albums_id) REFERENCES albums(id)
);

CREATE TABLE "filters" (
    id bigserial,
    user_id bigint NOT NULL,
    filter text,
    PRIMARY KEY (id)
);
