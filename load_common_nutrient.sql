DROP TABLE IF EXISTS `common_nutrient`;
CREATE TABLE `common_nutrient` (
  id int PRIMARY KEY REFERENCES nutrient(id)
);

.import common_nutrient.txt common_nutrient
