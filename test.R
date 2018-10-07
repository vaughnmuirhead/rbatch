library(bigrquery)
config <- config::get()
set_service_token(config$credentials)

project <- config$projectid
dataset <- bq_dataset(config$project, config$dataset)
table <- bq_table(project, dataset, config$table)

if (!bq_dataset_exists(dataset))
{
	msg <- 'Dataset {config$dataset} does not exist. Creating...'
	print(glue(msg))
	bq_dataset_create(dataset)
}

if (!bq_table_exists(table))
{
	msg <- 'Table {config$table} does not exist. Creating...'
	print(glue(msg))
	bq_table_create(table, fields = bq_field("Name", "string"), ("Counter", "integer"))
	print('BQ table created.')
	
	sql <- "INSERT INTO `{config$dataset}.{config$table}` (Name, Counter) VALUES ('Rjobs', 0)"
	glue(sql)
	data <- bq_project_query(project, sql)
	print('BQ table initialised successfully.')
}
 
sql <- "UPDATE `{config$dataset}.{config$table}` set Counter = Counter + 1 WHERE Name = 'Rjobs'" # Example query.
glue(sql)
 
data <- bq_project_query(project, sql)
print ("BQ query executed successfully!")