#### hgi-vault dev scripts

HGI internal Confluence documentation to deploy vault on `/lustre` project:
https://confluence.sanger.ac.uk/display/HGI/Vault+Deployment
  
[create-state.sh](create-state.sh) creates dummy testing files for Vault in a /lustre project.
[vault-cron-job.sh](vault-cron-job.sh) runs the vault sweep (sandman) periodically.