DROP TABLE IF EXISTS `weight`;
CREATE TABLE `weight` (
    food_id int REFERENCES food(id) NOT NULL,
    sequence_num int NOT NULL,
    amount float NOT NULL,
    description text NOT NULL,
    gm_weight float NOT NULL,
    num_data_pts int,
    std_dev float,
    PRIMARY KEY(food_id, sequence_num)
);

.separator "^"
.import data/WEIGHT.txt weight
