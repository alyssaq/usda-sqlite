#!/usr/bin/env python

import json
import sqlite3
import sys

if len(sys.argv) != 2:
  sys.exit('Must provide term to search for')

conn = sqlite3.connect('usda.sql3')
c = conn.cursor()
c.execute("""
  SELECT
    food.long_desc,
    SUM(nutrition.amount)
  FROM food
  JOIN nutrition
  ON nutrition.food_id = food.id
  WHERE food.long_desc LIKE ?
  AND nutrition.nutrient_id IN (621, 629)
  GROUP BY food.long_desc
""", ('%' + sys.argv[1] + '%',))

for row in c:
  print row[0], row[1]
