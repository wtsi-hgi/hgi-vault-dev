postgres_data=~/hgi-vault-dev/singularity_postgres/postgres_data
postgres_run=~/hgi-vault-dev/singularity_postgres/postgres_run

mkdir -p $postgres_data
mkdir -p $postgres_run

singularity run \
	--containall \
	-B ${postgres_data}:/var/lib/postgresql/data \
	-B ${postgres_run}:/var/run/postgresql \
	--env-file postgres_env_file.txt \
	postgres.sif
