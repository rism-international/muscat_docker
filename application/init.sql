DROP DATABASE muscat_3_0_development;
CREATE DATABASE muscat_3_0_development CHARACTER SET utf8 COLLATE utf8_general_ci;
-- DROP USER IF EXISTS'rism'@'%';
CREATE USER 'rism'@'%' IDENTIFIED BY 'rism689';
GRANT ALL ON muscat_3_0_development.* TO 'rism'@'%';
FLUSH PRIVILEGES;
use muscat_3_0_development;
source /tmp/import_db.sql;
