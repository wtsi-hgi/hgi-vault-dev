#### hgi-vault dev scripts

This branch slash_software is for the vault install at/software/hgi/installs/vault.

This repo hosts helper scripts to test & deploy [hgi-vault](https://github.com/wtsi-hgi/hgi-vault).  
cf. related HGI internal Confluence documentation to deploy vault on `/lustre` project:
https://confluence.sanger.ac.uk/display/HGI/Vault+Deployment
  
main scripts:
- [create-state.sh](create-state.sh) creates dummy testing files for Vault in a /lustre project.
- [cron_job.sh](cron_job.sh) runs the vault sweep (sandman).
- [upgrade-vault.sh](upgrade-vault.sh) updates the production install of vault & sandman (run as mercury).
- [bootstrap](bootstrap) can be used to activate python env, config and run vault and sandman if you create symlinks with those names pointing to bootstrap.
- [add_path.sh](add_path.sh) adds the main production vault & sandman executables to your path, along with the scripts in this repo.

deploy test postgress DB in Openstack instance:
[singularity_postgres](singularity_postgres/README.md)
