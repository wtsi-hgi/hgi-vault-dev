# activate python virtual env
# e.g. source /lustre/scratch118/humgen/hgi/projects/hgi_vault_dev/scratch123/hgi_vault_env/bin/activate
in which to install vault, then:
# pip install --upgrade pip

export TMPDIR=$PWD/local_tmp_dir
mkdir -p $TMPDIR

# PIP_CACHE_DIR doesn't work, still write in /nfs/users/nfs_m/mercury/.cache/pip/wheels ?
PIP_CACHE_DIR=$PWD/local_pip_cache_dir
mkdir -p $PIP_CACHE_DIR

cd ../hgi-vault
pip install .
