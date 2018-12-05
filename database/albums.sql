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
    FOREIGN KEY (transport_id) REFERENCES transports(id),
    FOREIGN KEY (user_id) REFERENCES users(id)

);
CREATE TABLE "albums_filters" (
    id bigserial,
    user_id bigint NOT NULL,
    filter text,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);