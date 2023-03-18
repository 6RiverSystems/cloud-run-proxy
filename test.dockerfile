FROM  us-docker.pkg.dev/plasma-column-128721/gcr.io/cloud-run-proxy:0.0.2 

COPY application_default_credentials.json /app/creds/application_default_credentials.json 
