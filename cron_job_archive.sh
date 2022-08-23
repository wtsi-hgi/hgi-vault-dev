#!/usr/bin/env bash

declare _SOFT="/software/hgi/installs/vault"
declare _WORK="/nfs/hgi/vault"

# Logging
declare DATE="$(date --iso-8601=minutes)"
declare LOG="${_WORK}/log/sandman-archive-${DATE}.log.gz"
exec &> >(tee >(gzip -c > "${LOG}"))

# Paths covered by vaults
declare -a VAULT_DIRS=(
	"/lustre/scratch119/humgen/projects/ddd"
	"/lustre/scratch123/hgi/projects/ddd"
	"/lustre/scratch119/humgen/projects/elgh_gsa"
	"/lustre/scratch119/humgen/projects/gel_rnaseq"
	"/lustre/scratch119/humgen/teams/martin"
	"/lustre/scratch123/hgi/projects/autozyg"
	"/lustre/scratch123/hgi/projects/birth_cohort_wes"
	"/lustre/scratch123/hgi/projects/ddd_genotype"
	"/lustre/scratch123/hgi/projects/predixcan"
	"/lustre/scratch123/hgi/teams/martin"
)

it_broke() {
  mail --subject="Sandman archive failed unexpectedly" hgi-team@sanger.ac.uk <<-EOF
	Sandman failed unexpectedly. Please check the logs immediately:

	  ${LOG}
	EOF
}

sudo -u sandman "${_SOFT}/sandman" --archive --force-drain "${VAULT_DIRS[@]}" || it_broke
