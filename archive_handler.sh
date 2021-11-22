#!/usr/bin/env bash

declare ROOT="/lustre/scratch118/humgen/hgi/projects/hgi_vault_dev/scratch123"
declare CROOK_ROOT="${ROOT}/code/crook-shepherd/crook"
declare VAULT_ROOT="${ROOT}/code/vault"

# Logging
exec 1>>"${VAULT_ROOT}/var/log/crook.log"
exec 2>&1
echo "## Start: $(date) ##"

# Init LSF
source /usr/local/lsf/conf/profile.lsf

# Ensure baton is available
export PATH="/software/hgi/installs/baton:/software/sciops/pkgg/baton/2.1.0/bin:${PATH}"

cd "${CROOK_ROOT}"
source "${CROOK_ROOT}/.venv/bin/activate"

set -eu
