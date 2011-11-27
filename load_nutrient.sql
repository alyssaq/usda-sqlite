DROP TABLE IF EXISTS `nutrient`;
CREATE TABLE `nutrient` (
  id int PRIMARY KEY NOT NULL,
  units text NOT NULL,
  tagname text NOT NULL DEFAULT '',
  name text NOT NULL,
  num_decimal_places text NOT NULL,
  sr_order int NOT NULL
);
CREATE INDEX nutrient_name_search_index ON nutrient(name);

.separator "^"
.import data/NUTR_DEF.txt nutrient
