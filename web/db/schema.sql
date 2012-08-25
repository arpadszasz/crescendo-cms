DROP DATABASE IF EXISTS crescendo;
CREATE DATABASE crescendo ENCODING 'UTF-8';
\connect crescendo;

BEGIN;

DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

SET NAMES 'UTF-8';
SET TIMEZONE TO 'UTC';

CREATE TABLE account (
    account_id                  SERIAL          PRIMARY KEY,
    username                    VARCHAR(64)     NOT NULL,
    password                    TEXT            NOT NULL
);

CREATE TABLE article (
    article_id                  SERIAL          PRIMARY KEY,
    title                       VARCHAR(128)    NOT NULL,
    content                     TEXT
);

CREATE TABLE category (
    category_id                 SERIAL          PRIMARY KEY,
    name                        VARCHAR(128)    NOT NULL
);

CREATE TABLE product (
    product_id                  SERIAL          PRIMARY KEY,
    name                        VARCHAR(128),
    code                        VARCHAR(64),
    description                 TEXT,
    price                       NUMERIC(10,2),
    discount_price              NUMERIC(10,2)
);

CREATE TABLE image (
    image_id                    SERIAL          PRIMARY KEY,
    filename                    VARCHAR(256)    NOT NULL
);

CREATE TABLE spec (
    spec_id                     SERIAL          PRIMARY KEY,
    name                        VARCHAR(32)
);

CREATE TABLE product_spec (
    product_spec_id             SERIAL          PRIMARY KEY,
    product_id                  SMALLINT        NOT NULL
                                    REFERENCES product(product_id),
    spec_id                     SMALLINT        NOT NULL
                                    REFERENCES spec(spec_id),
    value                       VARCHAR(64)
);

COMMIT;
