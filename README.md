# rbatch

Just a simple example project to demonstrate a pattern for creating a Docker image wich executes an R script.

- Note: To use the example R script you'll need a Google Cloud project with BigQuery enabled. Also, a great place to try this out is in the Google Cloud shell. https://cloud.google.com/shell/docs/quickstart

The example R script connects to Google BigQuery using the R bigrquery package and demonstrates:
1. Creation of a BigQuery dataset, table.
2. Performing a sql query against BigQuery.

# Configuration

After cloning this project perform the following configuration steps:
1. Create a service account in your Google Cloud Project which has the appropriate permissions to create datasets, tables and read/write to BigQuery.
2. Create a json credentials key for the service account and download the json file.
3. Update the config.yml file with:
- the path to the json key file you downloaded. e.g., credentials: '/home/myuser/creds.json'  
- your Google Cloud project id. e.g., projectid: 'my-cool-bq-project-123'
- The name of the BigQuery dataset you wish to use in your project (this will be created automatically if it does not already exist). e.g., dataset: 'mydataset'
- The name of the BigQuery table you wish the example to use (let the script create this table for you). e.g., table: 'myexampletable'

# Creating the Docker image
* Make sure you have Docker installed.

1. Run the following command to create the docker image (the last argument in the command is the path to where you saved this project):
- docker build -t rbatch /home/myuser/rbatch/

# Testing the Docker image
1. Run the following command to test your new image:
- docker run -t rbatch:latest

If all goes well you should see some output similar to the following:
 - [1] "BQ query executed successfully!"

# Next steps
Once you have successfully created your image you could:
1. Modify the project to use your own R script.
    - Update the Dockerfile to use your R script 
        ```
        CMD ["Rscript", "myscript.R"]
        ```
2. Register the image in the Google Cloud Container Registry (using GCP cloud shell to run these commands) .
    - e.g.,
        ```
        docker tag rbatch gcr.io/data-science-283604/rbatch:v0.1
        ```
        ```
        docker push gcr.io/your-gcp-project-id/rbatch
        ```
3. Deploy your image to a VM on Google Compute Engine or
4. deploy your image to Google Kubernetes Engine (GKE)
