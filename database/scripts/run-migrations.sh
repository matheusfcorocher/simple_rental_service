#!/bin/sh
# Script to run all migrations

for file in /database/migrations/*.sql; do
  echo "Running migration: $file"
  sqlite3 /database/data/service_rental.db < "$file"
done

echo "All migrations have been applied."
