FROM postgres:13.1
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=123456
ENV POSTGRES_DB=modou_hive
ENV PGDATA=/var/lib/postgresql/data
COPY db.init.hive.sql /docker-entrypoint-initdb.d/ 
EXPOSE 5432
CMD ["postgres"]