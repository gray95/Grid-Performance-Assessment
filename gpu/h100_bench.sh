#!/bin/bash --login

#SBATCH --account=scw1019
#SBATCH --partition=accel_ai_h100
#SBATCH --job-name=GridBench
#SBATCH --output=slurm_%J/h100_bench.out
#SBATCH --error=slurm_%J/h100_bench.err
#SBATCH --gres=gpu:1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4
#SBATCH --time=0-00:10  #maximum job time in D-HH:MM

echo "Job ${SLURM_JOB_ID} is running on ${HOSTNAME}."
echo "It has access to GPU ${CUDA_VISIBLE_DEVICES},"
echo "and ${SLURM_NTASKS} tasks."

GRID_CFG="gpu-h100"
BENCH=${SCRATCH}/envGridBench1794585796

GRID_BENCH=${BENCH}/prefix/gridbench_${GRID_CFG}/bin/Benchmark_Grid
GRID_BENCH_IO=${BENCH}/prefix/gridbench_${GRID_CFG}/bin/Benchmark_IO

echo "Using ${GRID_CFG} environment" 
echo "from: ${BENCH}"

# activate env
source ${BENCH}/env.sh ${GRID_CFG}

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export OMP_PROC_BIND=close

mpirun -np ${SLURM_NTASKS} ${GRID_BENCH} --mpi 1.1.1.2 \
                                         --no-benchmark-flops \
                                         --json-out ${SLURM_JOB_ID}_h100_gpu.json

