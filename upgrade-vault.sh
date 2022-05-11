#!/usr/bin/env bash

declare ROOT="/software/hgi/installs/vault"

cd "${ROOT}/repo"
git pull

source "${ROOT}/venv/bin/activate"
pip install --force-reinstall .
