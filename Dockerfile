FROM postgres:latest

# Note we need to remove all the "OWNER TO" lines from the sql script
COPY sql/schema.sql /docker-entrypoint-initdb.d/

