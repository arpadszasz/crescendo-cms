DROP DATABASE IF EXISTS crescendo_cms;
CREATE DATABASE IF NOT EXISTS crescendo_cms CHARSET=utf8;
USE crescendo_cms;
SET NAMES utf8;

DROP TABLE IF EXISTS `csnd_user`;
CREATE TABLE `csnd_user` (
    `id`                INT NOT NULL AUTO_INCREMENT,
    `username`          VARCHAR(64) NOT NULL,
    `password`          VARCHAR(128) NOT NULL,
    `email`             VARCHAR(128) NOT NULL,
    `name`              TEXT,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB CHARSET=utf8;
