#!/bin/bash
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

set -ex

: "${JUPYTER_BASE_URL:=/}"

echo ">> PWD: $(pwd)"
if [[ ! -z "${JUPYTER_API_TOKEN}" ]]; then
  # launched by JupyterHub, use single-user entrypoint
  #exec /usr/local/bin/start-singleuser.sh $*
  jupyter notebook --debug --allow-root \
          --config=/etc/jupyter/jupyter_notebook_config.py \
          --NotebookApp.base_url=${JUPYTER_BASE_URL} \
          --NotebookApp.token=${JUPYTER_API_TOKEN} \
          --NotebookApp.allow_origin="*" \
          --ip=0.0.0.0 $*
else
  if [[ ! -z "${JUPYTER_ENABLE_LAB}" ]]; then
    . /usr/local/bin/start.sh jupyter lab $*
  else
    . /usr/local/bin/start.sh jupyter notebook --allow-root \
          --config=/etc/jupyter/jupyter_notebook_config.py \
          --NotebookApp.base_url=${JUPYTER_BASE_URL} $*
  fi
fi
