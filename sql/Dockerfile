FROM postgres:latest

# Note we need to remove all the "OWNER TO" lines from the sql script
COPY schema.sql /docker-entrypoint-initdb.d/

