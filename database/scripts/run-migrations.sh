#!/bin/sh
# Script to run all migrations
echo "Starting migrations"
echo ""

for file in ./migrations/*.sql; do
  echo "Running migration: $file"
  sqlite3 ./data/rental_service.db < "$file"
  echo ""
done

echo "All migrations have been applied."
