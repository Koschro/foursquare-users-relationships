# foursquare-users-relationships

Using .dat files, we get the data about the Foursquare users, the registered Venues and all types of relationships under study. 

More specifically, we have data about the users and their properties, as well as the venues and their properties. 

Next, we see that users relate to each other through friendships and users relate to venues through check-ins and ratings. 

# Database creation 

Using the Power Shell of Windows where we implemented the following commands:

•	PS C:\Users\kos_c>  cd C:\Users\kos_c\Documents\Neo4j\Assignment

•	PS C:\Users\Maybach\Documents\Neo4j\Assignment> & 'C:\Program Files\Neo4j CE 2.3.2\bin\Neo4jImport.bat' --into foursquare  --nodes venues.csv --nodes users.csv --relationships ratings.csv --relationships checkins.csv --relationships socialgraph.csv
