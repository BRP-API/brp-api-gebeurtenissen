FROM postgres:17.7-alpine
COPY scripts/db/schema.sql docker-entrypoint-initdb.d/schema.sql
COPY scripts/projecties-db/init-user-db.sql docker-entrypoint-initdb.d/init-user-db.sql
