#!/bin/bash
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

set -e

: "${JUPYTERPORT_ROUTE:=/}"

if [[ ! -z "${JUPYTERHUB_API_TOKEN}" ]]; then
  # launched by JupyterHub, use single-user entrypoint
  #exec /usr/local/bin/start-singleuser.sh $*
  . /usr/local/bin/start.sh jupyter notebook --NotebookApp.base_url=${JUPYTERPORT_ROUTE} --NotebookApp.token="${JUPYTERHUB_API_TOKEN}" $*
else
  if [[ ! -z "${JUPYTER_ENABLE_LAB}" ]]; then
    . /usr/local/bin/start.sh jupyter lab $*
  else
    . /usr/local/bin/start.sh jupyter notebook --NotebookApp.base_url=${JUPYTERPORT_ROUTE} $*
  fi
fi
