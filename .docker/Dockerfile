FROM postgres:17.7-alpine
COPY scripts/db/schema.sql docker-entrypoint-initdb.d/schema.sql
COPY scripts/projecties-db/schema.sql docker-entrypoint-initdb.d/projecties-schema.sql
