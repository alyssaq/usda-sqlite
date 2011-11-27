#!/bin/bash

if [ $# -ne 1 ]
then
  echo "You must specify a sqlite file as an argument."
  exit 1
fi

echo "Normalizing data..."
sed -i s/~//g data/*.txt

echo "Loading food group..."
sqlite3 $1 < load_food_group.sql

echo "Loading food..."
sqlite3 $1 < load_food.sql

echo "Loading nutrient..."
sqlite3 $1 < load_nutrient.sql

echo "Loading nutrition..."
sqlite3 $1 < load_nutrition.sql

echo "Done."
