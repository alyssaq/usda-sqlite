#!/bin/bash

if [ $# -ne 1 ]
then
  echo "You must specify a sqlite file as an argument."
  exit 1
fi

echo "Normalizing data..."
find . -type f -name "*.txt" -exec sed -i.bak "s/~//g" {} \;
sed -i.bak "s/µ/mc/" data/NUTR_DEF.txt
rm data/*.bak

echo "Loading food group..."
sqlite3 $1 < load_food_group.sql

echo "Loading food..."
sqlite3 $1 < load_food.sql

echo "Loading nutrient..."
sqlite3 $1 < load_nutrient.sql
sqlite3 $1 < load_common_nutrient.sql

echo "Loading nutrition..."
sqlite3 $1 < load_nutrition.sql

echo "Done."
