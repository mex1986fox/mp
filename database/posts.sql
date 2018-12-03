CREATE TABLE "posts" (
    id bigserial,
    user_id bigint NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    date_create timestamp default current_timestamp,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);