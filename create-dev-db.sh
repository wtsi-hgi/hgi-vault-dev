#!/usr/bin/env bash

# Create a dev sandman db for the user

set -euo pipefail

force_flag=0
while getopts "f" o; do
	case $o in
		f)
			force_flag=1
			;;
	esac
done


CONFIG_ROOT=/software/hgi/installs/vault/etc
DB_HOST=hg-arch-p1.internal.sanger.ac.uk
DB_USER=hgi_dev
export PGPASSWORD=$(grep password: $CONFIG_ROOT/sandmanrc.dev | awk -F ' ' '{print $NF}')

[[ $force_flag -eq 1 ]] && psql -U $DB_USER -h $DB_HOST -d postgres -c "DROP DATABASE sandman_dev_$USER;"

set +e
psql -U $DB_USER -h $DB_HOST -d postgres -c "CREATE DATABASE sandman_dev_$USER;"
[[ $? -ne 0 ]] && echo 'use -f to drop and recreate database'
set -e

umask u=rw,go=
sed "s/--USER_SPECIFIC--/sandman_dev_$USER/" $CONFIG_ROOT/sandmanrc.dev > $CONFIG_ROOT/sandmanrc.$USER
