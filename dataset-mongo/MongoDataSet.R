source(here::here('dataset-mongo', 'MongoDBConnection.R'))
getAlarmTypeEventsWithMongo <- function(eventAlarmType, startDate, endDate, limitEvents)
{
  mongoconn = getMongoConnection();
  findAlarmQuery <- paste('{ alertOn: true, alarmType: "', 
                          eventAlarmType, 
                          '", $and: [ {timeStamp: { $gte: { $date: "', 
                          startDate, '"}}}, { timeStamp: { $lte: { $date: "', 
                          endDate, '" } } } ] }', 
                          sep = "", 
                          collapse = ""
  )
  queryEvents <- dbGetQueryForKeys(mongoconn, 
                                   "alerts", 
                                   findAlarmQuery, 
                                   "{_id: 1, timeStamp: 1, carId: 1, alertType: 1, currentValue: 1, thresholdValue: 1, eventSeverity: 1}", 
                                   0, limitEvents)
  return (queryEvents);
}

getDTCTypeEventsWithMongo <- function(startDate, endDate, limitEvents = 10000000)
{
  mongoconn = getMongoConnection();
  findQuery <- paste('{ alertOn: true, alertType: "DTC",', 
                     '$and: [ {timeStamp: { $gt: { $date: "', 
                     startDate, '"}}}, { timeStamp: { $lt: { $date: "', 
                     endDate, '" } } } ] }', 
                     sep = "", 
                     collapse = ""
  )
  queryEvents <- dbGetQueryForKeys(mongoconn, 
                                   "alerts", 
                                   findQuery, 
                                   "{_id: 1, timeStamp: 1, dtcCodeInt: 1, dtcCode: 1}", 
                                   0, limitEvents)
  
  return (queryEvents);
}

getTripsWithMongo <- function(startedOn, endedOn, limitCount)
{
  mongoconn = getMongoConnection();
  findQuery <- paste('{ complete: true, ', 
                     'startedOn: { $gte: { $date: "', 
                     startedOn, '"}}, endedOn: { $lte: { $date: "', 
                     endedOn, '" } } }', 
                     sep = "", 
                     collapse = ""
  )
  queryTrips <- dbGetQueryForKeys(mongoconn, 
                                  "trips", 
                                  findQuery, 
                                  '{_id: 1, carId: 1, startedOn: 1, endedOn: 1, totalMileage: 1, totalRunTime: 1, totalIdleTime: 1}', 
                                  0, limitCount)
  
  return (queryTrips);
}

getVehicleTripsWithMongo <- function(vehicleId, startedOn, endedOn, limitCount)
{
  mongoconn = getMongoConnection();
  findQuery <- paste('{ complete: true, carId: ',
                     vehicleId,
                     ', startedOn: { $gte: { $date: "', 
                     startedOn, '"}}, endedOn: { $lte: { $date: "', 
                     endedOn, '" } } }', 
                     sep = "", 
                     collapse = ""
  )
  vehicleTrips <- dbGetQueryForKeys(mongoconn, 
                                    "trips", 
                                    findQuery, 
                                    "{_id: 1, carId: 1, startedOn: 1, endedOn: 1, totalMileage: 1, totalRunTime: 1, totalIdleTime: 1}", 
                                    0, limitCount)
  
  return (vehicleTrips);
}

getTripsWithEndLocation <- function(startedOn, endedOn, limitCount)
{
  mongoconn = getMongoConnection();
  findQuery <- paste('{ complete: true, ', 
                     'startedOn: { $gte: { $date: "', 
                     startedOn, '"}}, endedOn: { $lte: { $date: "', 
                     endedOn, '" } } }', 
                     sep = "", 
                     collapse = ""
  )
  queryTrips <- dbGetQueryForKeys(mongoconn, 
                                  "trips", 
                                  findQuery, 
                                  '{_id: 1, carId: 1, startedOn: 1, endedOn: 1, totalMileage: 1, 
                                  totalRunTime: 1, totalIdleTime: 1, 
                                  "endLoc": 1, 
                                  "startLoc": 1}', 
                                  0, limitCount)
  
  return (queryTrips);
}

getAlarmTypeEventsTimestamped <- function(vehicleId, eventAlarmType, startDateMillis, endDateMillis, limitEvents)
{
  mongoconn = getMongoConnection();
  findAlarmQuery <- paste('{ alertOn: true, alarmType: "', 
                          eventAlarmType, 
                          '", carId: ', vehicleId,
                          ', $and: [ {timeStamp: { $gte: { $date: { "$numberLong" : "', 
                          startDateMillis, '"}}}}, { timeStamp: { $lte: { $date: { "$numberLong" : "', 
                          endDateMillis, '" } } } } ] }', 
                          sep = "", 
                          collapse = ""
  )
  queryEvents <- dbGetQueryForKeys(mongoconn, 
                                   "alerts", 
                                   findAlarmQuery, 
                                   "{_id: 1, timeStamp: 1, alarmType: 1, currentValue: 1, thresholdValue: 1}", 
                                   0, limitEvents)
  return (queryEvents);
}

getVehicleMonthlyTripsWithMongo <- function(vehicleId, startedOn, endedOn, limitCount)
{
  mongoconn = getMongoConnection();
  findQuery <- paste('{ month: 12, year: 2015 }', 
                     sep = "", 
                     collapse = ""
  )
  vehicleTrips <- dbGetQueryForKeys(mongoconn, 
                                    "tripsanalytics", 
                                    findQuery, 
                                    "{_id: 1, carId: 1, tripCount: 1, distance: 1, runTime: 1, idleTime: 1, day: 1, week: 1, month: 1, year: 1}", 
                                    0, limitCount)
  
  return (vehicleTrips);
}