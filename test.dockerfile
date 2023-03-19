FROM  us-docker.pkg.dev/plasma-column-128721/gcr.io/cloud-run-proxy:0.0.2 
ENV GOOGLE_APPLICATION_CREDENTIALS=/app/creds/application_default_credentials.json 
COPY application_default_credentials.json /app/creds/application_default_credentials.json 
