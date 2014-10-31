#!/usr/bin/env python

import sqlite3
import sys

if len(sys.argv) != 2:
  sys.exit('Must provide text to search for')

conn = sqlite3.connect('usda.sql3')
search_clause = '%' + sys.argv[1] + '%'
c = conn.cursor()
c.execute('SELECT id, long_desc FROM food WHERE long_desc LIKE ?', (search_clause,))
for row in c:
  print row[0], row[1]
