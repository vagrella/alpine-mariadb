CREATE DATABASE IF NOT EXISTS `db_teste` DEFAULT CHARACTER SET utf8;

USE `db_teste`;

DROP TABLE IF EXISTS `tb_teste`;

CREATE TABLE `tb_teste` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cl_teste1` varchar(255) NOT NULL,
  `cl_teste2` smallint(6) NOT NULL,
  `cl_teste3` char(1) NOT NULL,
  `cl_teste4` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`cl_teste1`, `cl_teste2`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
