#Libraries import
install.packages("RNeo4j")
install.packages("stringr")
require(RNeo4j)
require(stringr)

#Data Import

#Users
users=read.table("users.dat", sep = "|",header = F,skip=2)
users[is.na(users)]=0
colnames(users)=c("user_id","user_lat","user_long")

#Socialgraph
socialgraph=read.table("socialgraph.dat", sep = "|",header = F,skip=2,fill = T)
socialgraph=socialgraph[-(which(!complete.cases(socialgraph))),]
colnames(socialgraph)=c("first_user_id","second_user_id")
socialgraph$first_user_id = str_trim(socialgraph$first_user_id)  ##because there is a space in front of the number we need to remove it
socialgraph$first_user_id = as.numeric(socialgraph$first_user_id)  ##after the trim we need to reassign the column as numeric

#Checkins
checkins=read.table("checkins.dat", sep = "|",header = F,skip=2)
checkins[is.na(checkins)]=0
colnames(checkins)=c("check_id","user_id","venue_id","latitude","longitude","created_at")

#Ratings
ratings=read.table("ratings.dat", sep = "|",header = F,skip=2)
colnames(ratings)=c("user_id","venue_id","rating")

#Venues
venues=read.table("venues.dat", sep = "|",header = F,skip=2)
venues[is.na(venues)]=0
colnames(venues)=c("venue_id","venue_lat","venue_long")


#Convert Data for the import tool of Neo4j and create .txt files
#Note: In oreder to import them to Neo4j first change .txt to .csv after the creation
new_users = cbind(users,rep("Person",nrow(users)))
colnames(new_users) = c("userID:ID","Lat","Lon",":LABEL")
new_users$`userID:ID` = paste("u",new_users$`userID:ID`,sep = "")
write.table(new_users,"users.txt",sep = ",",quote = F, row.names = F)

new_venues$`venueID:ID` = paste("v",new_venues$`venueID:ID`,sep = "")
colnames(new_venues) = c("venueID:ID","Lat","Lon",":LABEL")
write.table(new_venues,"venues.txt",sep = ",",quote = F, row.names = F)

new_ratings = cbind(ratings,rep("Rates",nrow(ratings)))
colnames(new_ratings)=c(":START_ID",":END_ID","rating",":TYPE")
new_ratings$`:START_ID` = paste("u",new_ratings$`:START_ID`,sep = "")
new_ratings$`:END_ID` = paste("v",new_ratings$`:END_ID`,sep = "")
write.table(new_ratings,"ratings.txt",sep = ",",quote = F, row.names = F)

new_checkins = cbind (checkins,rep("Checkin",nrow(checkins)))
colnames(new_checkins)=c("checkinID:ID",":START_ID",":END_ID","Lat","Lon","created",":TYPE")
new_checkins$`:START_ID` = paste("u",new_checkins$`:START_ID`,sep = "")
new_checkins$`:END_ID` = paste("v",new_checkins$`:END_ID`,sep = "")
new_checkins = new_checkins[,-1]
write.table(new_checkins,"checkins.txt",sep = ",",quote = F, row.names = F)

new_socialgraph = cbind(socialgraph,rep("Knows",nrow(socialgraph)))
colnames(new_socialgraph)=c(":START_ID",":END_ID",":TYPE")
new_socialgraph$`:START_ID` = paste("u",new_socialgraph$`:START_ID`,sep = "")
new_socialgraph$`:END_ID` = paste("u",new_socialgraph$`:END_ID`,sep = "")
write.table(new_socialgraph,"socialgraph.txt",sep = ",",quote = F, row.names = F)

