library(bigrquery)
library(glue)
config <- config::get()
set_service_token(config$credentials)

project <- config$projectid
ds <- bq_dataset(config$project, config$dataset)
tbl <- bq_table(config$projectid, config$dataset, config$table)

# Create dataset if it doesn't already exist.
if (!bq_dataset_exists(ds))
{
	msg <- 'Dataset {config$dataset} does not exist. Creating...'
	print(glue(msg))
	bq_dataset_create(ds)
}

# Create table if it doesn't already exist.
if (!bq_table_exists(tbl))
{
	msg <- 'Table {config$table} does not exist. Creating...'
	print(glue(msg))
	bq_table_create(tbl, fields = list(bq_field("Name", "string"), bq_field("Counter", "integer")))
	print('BQ table created.')
	
	# Init table with a value to update.
	sql <- glue("INSERT INTO {config$dataset}.{config$table} (Name, Counter) VALUES ('Rjobs', 0)")
	
	data <- bq_project_query(project, sql)
	print('BQ table initialised successfully.')
}
 
# This query will simply increment the Counter value by one each time it is executed.
sql <- glue("UPDATE {config$dataset}.{config$table} set Counter = Counter + 1 WHERE Name = 'Rjobs'") # Example query.
 
data <- bq_project_query(project, sql)
print ("BQ query executed successfully!")