DROP TABLE IF EXISTS `food_group`;
CREATE TABLE `food_group` (
  id int PRIMARY KEY,
  name text NOT NULL
);

.separator "^"
.import data/FD_GROUP.txt food_group
