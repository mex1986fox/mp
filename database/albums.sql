CREATE TABLE "albums" (
    id bigserial,
    user_id bigint NOT NULL,
    name text,
    date_create timestamp default current_timestamp,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);