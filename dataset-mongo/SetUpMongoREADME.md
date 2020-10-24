
1. Donwload and setup mongo db

2. Create drivingdataset database.

3. Download json dataset from Kaggel

4. Import trips dataset to mongo
bin/mongo
use drivingdataset;
bin/mongoimport --db=drivingdataset --collection=trips --legacy --file=tripsdataset.json 

5. Check trip count
db.trips.count()
#

6. Import alerts dataset to mongo
bin/mongoimport --db=drivingdataset --collection=trips --legacy --file=alertsdataset.json 

7.Check alert count
db.alerts.count()
#1863668