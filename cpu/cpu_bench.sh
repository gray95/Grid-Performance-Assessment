#!/bin/bash --login

#SBATCH --account=scw1019
#SBATCH --partition=compute
#SBATCH --job-name=gridFlops
#SBATCH --output=slurm_%J/flops_bench.out
#SBATCH --error=slurm_%J/flops_bench.err
#SBATCH --time=0-00:10  #maximum job time in D-HH:MM
#SBATCH --nodes=1 
#SBATCH --exclusive 
#SBATCH --ntasks=2
#SBATCH --ntasks-per-socket=16
#SBATCH --cpus-per-task=16

BENCH=${SCRATCH}/envGridBench1793631924
GRID_BENCH=${BENCH}/prefix/gridbench_cpu/bin/Benchmark_Grid

# activate env
source ${BENCH}/env.sh cpu

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export OMP_PROC_BIND=close

echo "using ${SLURM_NTASKS} tasks"
echo "over ${SLURM_JOB_CPUS_PER_NODE} cpus per node"

mpirun -np 2 $GRID_BENCH --mpi 1.1.1.2 \
                         --json-out ${SLURM_JOB_ID}_cpu_flops.json

