#!/usr/bin/env bash
set -euo pipefail

DB_NAME="beach"
MIGRATIONS_DIR="database/migrations"

echo "Resetting database: ${DB_NAME}"

# Drop DB (terminate active connections first)
psql -d postgres -v ON_ERROR_STOP=1 <<SQL
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = '${DB_NAME}'
  AND pid <> pg_backend_pid();

DROP DATABASE IF EXISTS ${DB_NAME};
CREATE DATABASE ${DB_NAME};
SQL

echo "Running migrations..."

psql -d "${DB_NAME}" -v ON_ERROR_STOP=1 -f "${MIGRATIONS_DIR}/001_create_tables.sql"
psql -d "${DB_NAME}" -v ON_ERROR_STOP=1 -f "${MIGRATIONS_DIR}/002_add_constraints.sql"
psql -d "${DB_NAME}" -v ON_ERROR_STOP=1 -f "${MIGRATIONS_DIR}/003_add_fk_indexes.sql"
psql -d "${DB_NAME}" -v ON_ERROR_STOP=1 -f "${MIGRATIONS_DIR}/004_reference_data.sql"

echo "✅ Done. Database '${DB_NAME}' rebuilt successfully."