
create 3.10 virtual env
```
export ENV_NAME=py310
export INSTALL_DIR=/software/hgi/installs/anaconda3/envs
export CONDA_PKGS_DIRS=/lustre/scratch118/humgen/resources/conda_pkgs
conda create --prefix $INSTALL_DIR/$ENV_NAME python=3.10
conda activate $INSTALL_DIR/$ENV_NAME

# add venv
python -m venv /software/hgi/installs/anaconda3/envs/py310/venv

source /software/hgi/installs/anaconda3/envs/py310/venv/bin/activate
python -m pip install --upgrade pip

# install poetry project
poetry install
```

```
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
export PATH=/nfs/users/nfs_m/mercury/.local/bin:$PATH
poetry --version

poetry new poetry-demo && mv poetry-demo poetry
```