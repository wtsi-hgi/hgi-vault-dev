#!/usr/bin/env bash

declare _SOFT="/software/hgi/installs/vault"
declare _WORK="/nfs/hgi/vault"

# Logging
declare DATE="$(date --iso-8601=minutes)"
declare LOG="${_WORK}/log/sandman-${DATE}.log.gz"
exec &> >(tee >(gzip -c > "${LOG}"))

# Paths covered by vaults
declare -a VAULT_DIRS=(
    "/lustre/scratch123/hgi/mdt1/teams/hurles_tmp_share"
    "/lustre/scratch123/hgi/projects/ukbb_scrna"
)
  # "/lustre/scratch119/realdata/mdt3/projects/cramtastic"
  # "/lustre/scratch123/hgi/mdt1/teams/hurles_tmp_share"
  # "/lustre/scratch123/hgi/projects/ukbb_scrna"

it_broke() {
  mail --subject="Sandman failed unexpectedly" hgi-team@sanger.ac.uk <<-EOF
	Sandman failed unexpectedly. Please check the logs immediately:

	  ${LOG}
	EOF
}

sudo -u sandman "${_SOFT}/sandman" --weaponise --force-drain "${VAULT_DIRS[@]}" || it_broke
