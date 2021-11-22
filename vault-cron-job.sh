#!/usr/bin/env bash

declare ROOT="/lustre/scratch119/realdata/mdt3/teams/hgi/vault"

# Logging
declare DATE="$(date --iso-8601=minutes)"
declare LOG="${ROOT}/var/log/sandman-${DATE}.log"
exec &> >(tee "${LOG}")

# Paths covered by vaults
declare -a VAULT_DIRS=(
  #"/lustre/scratch114/teams/hgi"
  #"/lustre/scratch119/realdata/mdt3/projects/cramtastic"
)

it_broke() {
  mail --subject="Sandman failed unexpectedly" hgi-team@sanger.ac.uk <<-EOF
	Sandman failed unexpectedly. Please check the logs immediately:
	
	  ${LOG}
	EOF
}

sudo -u sandman "${ROOT}/bin/sandman" --weaponise --force-drain "${VAULT_DIRS[@]}" || it_broke
#sudo -u sandman "${ROOT}/bin/sandman" "${VAULT_DIRS[@]}" || it_broke
