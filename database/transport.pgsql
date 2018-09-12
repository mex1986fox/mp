-- drop TABLE transports_bodies, transports_fuels,
-- transports_wheels, transports_drives, transports_models, transports_brands, transports;
CREATE TABLE transports(
    id serial NOT NULL,
    name varchar(32),
    name_url varchar(32),
    PRIMARY KEY (id)
);
CREATE TABLE transports_brands(
    id serial NOT NULL,
    transport_id INTEGER,
    name varchar(32),
    name_url varchar(32),
    PRIMARY KEY (id),
    FOREIGN KEY (transport_id) REFERENCES transports(id)
);
CREATE TABLE transports_models(
    id serial NOT NULL,
    transport_id INTEGER,
    brand_id INTEGER,
    name varchar(32),
    name_url varchar(32),
    PRIMARY KEY (id),
    FOREIGN KEY (transport_id) REFERENCES transports(id),
    FOREIGN KEY (brand_id) REFERENCES transports_brands(id)
);
CREATE TABLE transports_drives(
    id serial NOT NULL,
    transport_id INTEGER,
    name varchar(32),
    name_url varchar(32),
    PRIMARY KEY (id),
    FOREIGN KEY (transport_id) REFERENCES transports(id)
);
CREATE TABLE transports_fuels(
    id serial NOT NULL,
    transport_id INTEGER,
    name varchar(32),
    name_url varchar(32),
    PRIMARY KEY (id),
    FOREIGN KEY (transport_id) REFERENCES transports(id)
);
CREATE TABLE transports_volums(
    id serial NOT NULL,
    transport_id INTEGER,
    value NUMERIC(2,1),
    PRIMARY KEY (id),
    FOREIGN KEY (transport_id) REFERENCES transports(id)
);


CREATE TABLE transports_bodies(
    id serial NOT NULL,
    transport_id INTEGER,
    name varchar(32),
    name_url varchar(32),
    PRIMARY KEY (id),
    FOREIGN KEY (transport_id) REFERENCES transports(id)
);