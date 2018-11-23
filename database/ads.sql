CREATE TABLE "ads" (
    id bigserial,
    user_id bigint NOT NULL,
    settlements_id smallint NOT NULL,
    model_id smallint NOT NULL,
    body_id smallint ,
    drive_id smallint ,
    fuel_id smallint ,
    transmission_id smallint ,
    wheel varchar(1) ,
    engin_volume smallint ,
    engin_power smallint,
    year smallint NOT NULL,
    price money NOT NULL,
    mileage numeric(8),
    description text,
    documentation boolean,
    repair boolean,
    exchange boolean,
    PRIMARY KEY (id),
    FOREIGN KEY (settlements_id) REFERENCES locations_settlements(id),
    FOREIGN KEY (model_id) REFERENCES transports_models(id),
    FOREIGN KEY (body_id) REFERENCES transports_bodies(id),
    FOREIGN KEY (drive_id) REFERENCES transports_drives(id),
    FOREIGN KEY (fuel_id) REFERENCES transports_fuels(id),
    FOREIGN KEY (transmission_id) REFERENCES transports_transmissions(id)
);
CREATE TABLE "ads_filters" (
    id bigserial,
    user_id bigint NOT NULL,
    filter text,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);