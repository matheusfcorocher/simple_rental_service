# Use an official SQLite image from Docker Hub or a lightweight base image like alpine
FROM alpine:latest

# Install SQLite
RUN apk add --no-cache sqlite

# Set the working directory
WORKDIR /database

# Copy migrations and scripts files  into the container (if you have one)
COPY ../database/migrations /database/migrations
COPY ../database/scripts /database/scripts

# Create sqlite database and run migrations
RUN chmod +x ./scripts/run-migrations.sh

# Command to keep the container running in the background
CMD ["sh", "-c", "while :; do sleep 1; done"]
