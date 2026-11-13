#!/usr/bin/env bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

BENCH_REPO=${HOME}/grid-benchmark

GRID_ENV=${SCRATCH}/envGridBench$(date +%s)

NCORES=$(nproc)

# check if repo already exists
if [ -d ${BENCH_REPO} ]; then
  echo "Benchmark repo already cloned into ${BENCH_REPO}"
else
  git clone -b sunbird git@github.com:gray95/grid-benchmark.git ${BENCH_REPO}
fi

echo "Select a machine from the following:"
ls ${BENCH_REPO}/systems

read -p "Chosen Machine: " GRID_SYS

echo "Available partitions:"
grep name ${BENCH_REPO}/systems/${GRID_SYS}/grid-config.json | cut -d : -f 2

read -p "Chosen Partition: " GRID_CFG

# create benchmark environment
${BENCH_REPO}/bootstrap-env.sh ${GRID_ENV} ${GRID_SYS}

# activate benchmark environment
. ${GRID_ENV}/env.sh ${GRID_CFG}

# build Grid
${BENCH_REPO}/build-grid.sh ${GRID_ENV} ${GRID_CFG} $NCORES

# build benchmarks
${BENCH_REPO}/build-benchmark.sh ${GRID_ENV} ${GRID_CFG} $NCORES

