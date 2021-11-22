postgres_data=/home/ubuntu/postgres_data
postgres_run=/home/ubuntu/postgres_run

mkdir -p $postgres_data
mkdir -p $postgres_run

singularity run \
	--containall \
	-B ${postgres_data}:/var/lib/postgresql/data \
	-B ${postgres_run}:/var/run/postgresql \
	--env-file postgres_env_file.txt \
	postgres.sif
