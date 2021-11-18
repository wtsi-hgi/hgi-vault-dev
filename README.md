#### hgi-vault dev scripts

This repo hosts example helper scripts to test & deploy vault.  
cf. related HGI internal Confluence documentation to deploy vault on `/lustre` project:
https://confluence.sanger.ac.uk/display/HGI/Vault+Deployment
  
main scripts:
- [create-state.sh](create-state.sh) creates dummy testing files for Vault in a /lustre project.
- [vault-cron-job.sh](vault-cron-job.sh) runs the vault sweep (sandman) periodically.