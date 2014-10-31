#!/usr/bin/env python

import json
import sqlite3
import sys

if len(sys.argv) != 2:
  sys.exit('Must provide food id to get nutrition for')

conn = sqlite3.connect('usda.sql3')
c = conn.cursor()
c.execute("""
  SELECT
    name,
    units,
    amount
  FROM nutrition
  JOIN nutrient
  JOIN common_nutrient
  ON nutrition.food_id = ?
  AND nutrition.nutrient_id = nutrient.id
  AND nutrient.id = common_nutrient.id
""", (sys.argv[1],))
vals = {}
for row in c:
  vals[row[0]] = str(row[2]) + ' ' + row[1]

print json.dumps(vals, sort_keys=True, indent=4)
