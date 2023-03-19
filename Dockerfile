FROM golang:1.19-bullseye as builder

# Create and change to the app directory.
WORKDIR /app

# Retrieve application dependencies.
# This allows the container build to reuse cached dependencies.
# Expecting to copy go.mod and if present go.sum.
COPY go.* ./
RUN go mod download

# Copy local code to the container image.
COPY . ./

# Build the binary.
RUN CGO_ENABLED=0 go build -ldflags="-s -w -extldflags=-static" -v -o cloud-run-proxy

# Use the official Debian slim image for a lean production container.
# https://hub.docker.com/_/debian
# https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
FROM nginx:1.23.3
ENTRYPOINT ["/app/run.sh"]

RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install sudo -y \
    ca-certificates nginx apache2-utils && \
    rm -rf /var/lib/apt/lists/*
COPY ./docker-deps/run.sh /app/run.sh 
COPY ./docker-deps/default.conf /etc/nginx/conf.d/default.conf
COPY ./docker-deps/nginx.conf /etc/nginx/nginx.conf
# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/cloud-run-proxy /app/cloud-run-proxy
