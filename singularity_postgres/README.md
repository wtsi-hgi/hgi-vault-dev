#### test postgres DB

example command to log into postgres DB:
```
psql -h 172.27.25.226 -p 5432 -U db_username db_name
```

##### deploy fb
create container:
```
bash singularity_build.sh
```

start DB:
edit `postgres_env_file.txt.example` into `postgres_env_file.txt`, then
```
bash singularity_run.sh
```

#### docs
https://hub.docker.com/_/postgres/  
https://brechtv.medium.com/running-postgresql-inside-a-singularity-container-f054c5ef1305

#### frontend
deploy frontend DB on FCE instance with pgAdmin 4:  
https://www.pgadmin.org/download/pgadmin-4-apt/
