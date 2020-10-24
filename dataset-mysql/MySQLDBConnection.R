library(RMySQL)
createConnection <- function()
{
  conn <- dbConnect(RMySQL::MySQL(max.con = 500, fetch.default.rec = 100), user = 'analytics', password = 'analytics', dbname = 'analytics')  
  
  return (conn)
}

closeConnection <- function(conn)
{
  RMySQL::dbDisconnect(conn)
}

setupDBFromClean <- function(conn)
{
  dbListTables(conn)
  dbRemoveTable(conn, "trips")
}

readScoreData <- function(conn)
{
  scoredata <- RMySQL::dbReadTable(conn, "trips")
  #print(scoredata)
  return (scoredata)
}

readScoreDataFiltered <- function(sqlquery)
{
  scoredata <- DBI::dbGetQuery(createConnection(), sqlquery)
  
  #print(scoredata)
  return (scoredata)
}

readScoreDataFiltered <- function(conn, sqlquery)
{
  scoredata <- DBI::dbGetQuery(conn, sqlquery)
  
  #print(scoredata)
  return (scoredata)
}