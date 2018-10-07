library(bigrquery)
config <- config::get()
set_service_token(config$credentials)

project <- config$projectid
 
sql <- "UPDATE `test1.test2` set Counter = Counter + 1 WHERE AddressId = 'testaddress'" # Example query.
 
data <- bq_project_query(project, sql)
print ("BQ query executed successfully!")