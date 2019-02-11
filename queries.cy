1. match (v:Venue{venueID:'v1008372'})<-[r:Rates]-(n:Person) 
return count(n) as num_of_rating, avg(toInt(r.rating)) as avg_rating order by avg_rating desc;
 
2. match (p:Person)-[c:Checkin]->(v:Venue) 
with v.venueID as id_of_venue,count(v) as number_of_checkins 
return id_of_venue,max(number_of_checkins) as max_checkins 
order by max_checkins desc limit 1;

3. match (p {userID:'u1136519'})-[:Knows*2..2]-(friend_of_friend)
where not (p)-[:Knows]-(friend_of_friend)
return count(*);
 
4. match (p:Person)-[r:Rates]->(v:Venue) 
with v.venueID as id_of_venue,avg(toInt(r.rating)) as avg_rating,count(r.rating) as number_of_ratings
where avg_rating > 4 
return id_of_venue,number_of_ratings, avg_rating 
order by avg_rating desc;
