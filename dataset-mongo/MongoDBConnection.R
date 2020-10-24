options( java.parameters = "-Xmx4096m" )
options(scipen = 999)
library(rJava)
.jinit()
library(RMongo)
library(plyr)

getMongoConnection <- function()
{ 
  mongo <- mongoDbReplicaSetConnectWithCredentials(dbName = "drivingdataset", 
                                                   hosts = "127.0.0.1:27017", 
                                                   username = "drivingdata", 
                                                   pwd = "drivingdata");
  return (mongo);        
}

setupMongoConnectionRemote <- function(db, host, usr, pwd)
{ 
  mongoconn <- mongoDbReplicaSetConnectWithCredentials(dbName = db, 
                                                       hosts = host, 
                                                       username = usr, 
                                                       pwd = pwd);
  
  return (mongoconn);        
}