#!/usr/bin/env bash

# clear a developers test DB

set -euo pipefail

CONFIG_ROOT=/software/hgi/installs/vault/etc
DB_HOST=hg-arch-p1.internal.sanger.ac.uk
DB_USER=hgi_dev
export PGPASSWORD=$(grep password: $CONFIG_ROOT/sandmanrc.$USER | awk -F ' ' '{print $NF}')

psql -U $DB_USER -h $DB_HOST -d sandman_dev_$USER -c "DELETE FROM files; DELETE FROM group_owners; DELETE FROM groups;"
