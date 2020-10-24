source(here::here('dataset-mysql', 'MySQLDBConnection.R'))


setupReverseGeocodingData <- function()
{
  conn <- createConnection()
  insertReverseGeoCodingData(conn)
  closeConnection(conn)
}

setupWeatherData <- function()
{
  conn <- createConnection()
  updateWeatherData(conn)
  closeConnection(conn)
}