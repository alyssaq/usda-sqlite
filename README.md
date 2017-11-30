# USDA database to SQLite

Converts the USDA food database to SQLite.

The USDA has a database of nutritional information for many foods available at:

http://www.ars.usda.gov/Services/docs.htm?docid=8964

By default it's contained in flat files. This project includes scripts to generate appropriate schema and import them into a SQLite database. I've also hand generated a subset of the nutrients that includes commonly-familiar nutrients vs. the very extensive list provided by the USDA.

You will need to first download the files and unzip them into the `data` directory. Files for SR28 are included. 

Run create_db.sh with the name of output database:
```sh
$ ./create_db.sh usda.sql3
```
On my system it takes about 10 seconds to populate the db.

Some example scripts to query the db are in the `example` folder. Sample usage:
```sh
$ python example/nutrition.py 01001
$ python example/search.py salmon
```
## SQLlite browser
I recommend using the open source [sqlitebrowser](http://sqlitebrowser.org/) to view the `usda.sql3` database.
![sqllitebrowser_screenshot](
https://github.com/sqlitebrowser/sqlitebrowser/raw/master/images/sqlitebrowser.png)

You can also upload the created `*.sql3` file to https://sqliteonline.com/, saving yourself from needing to download any applications.

## Usage Examples

### SQL

- `SELECT * FROM nutrient;` - print out all nutrient data
- `SELECT Count(*) FROM food;` - 8789 - all foods
- `SELECT Count(*) FROM food where food_group_id !=300 and food_group_id !=3500` - 8257 - Exclude all baby food and Native American food
- `SELECT id FROM food;` - [ [food.id] ]
- `SELECT id,long_desc FROM food;` - [ [food.id, food.long_desc] ]
- `SELECT id,name FROM nutrient;` - [ [nutrient.id, nutrient.name] ]
- `SELECT count(*),food_group.name FROM food inner join food_group on food.food_group_id=food_group.id group by food_group_id; ` - the count of all the foods in each food group

Every food's serving size, if it has one

```sql
SELECT 
  food.id,
  food.long_desc,
  gm_weight
FROM food 
INNER JOIN weight ON weight.food_id=food.id
where weight.description=='serving';
```

Nutrient amounts per 100g of food

```sql
SELECT 
  food.id,
  nutrient.id,
  nutrition.amount
FROM nutrition 
INNER JOIN food ON nutrition.food_id=food.id 
INNER JOIN nutrient ON nutrition.nutrient_id=nutrient.id;
```

### Post processing

You can export this data to JSON and do further processing, like indexing. Indexing speeds up access for client Applications and reduces file size (by removing redundant data). Indexing the final SQL example reduces JSON representation from ~10MB to 7.0MB.

```js
import Amt from './UsdaAmounts'; //results of the final query: [ [food.id, nutrient.id, nutrition.amount] ] for every food
let b = Amt.reduce((total, curr) => {
  const foodId = curr[0];
  const nutrientId = curr[1];
  const amt = curr[2];
  const foodIsNew = !(foodId in total);
  if (foodIsNew) total[foodId] = {};
  total[foodId][nutrientId] = amt;
  return total;
}, {})
console.log(JSON.stringify(b)); //note this add " characters to the beginning and end when printing to the console
```

## Attribution
Adapted from <https://github.com/czarandy/usda> for scripts to run on Mac OS X with SR28 release.
