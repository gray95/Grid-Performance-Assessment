## Disclaimer
1. This report is not a commentary on code quality, but an indicator of the quality of the current SHAREing testing methodology as of October 2026.
2. The pre-assessment is only a preliminary assessment of submission suitability and does not guarantee a full assessment. It will be provided to the submitter indicating if the full assessment will be undertaken or detail reasons for rejection.
## Assessment objective

This performance pre-assessment is a test submission of [`Grid`](https://github.com/paboyle/Grid), commit ID:`3232b438f2cf729e515c185e2dbf29d7cc276bb7`. The submission contains the `Benchmark_Grid` and `Benchmark_IO` [benchmarks](https://github.com/gray95/grid-benchmark/tree/sunbird1). It was carried out by __Dr Gaurav Ray__ with support from __Dr Ed Bennett__, both of __Swansea University__, from the 12th to the 23rd of October 2026. This work was funded by a SHAREing grant (insert ID). In this instance we are acting as both submitter and assessor. 
## Table of contents

- [x] [1: Benchmark setup](#1-benchmark-setup)
- [ ] [2: Description of working environment](#2-description-of-working-environment)
- [ ] [3: Compiler setup and optimisations](#3-compiler-setup-and-optimisations)
- [ ] [4: Computational complexity and scaling](#4-computational-complexity-and-scaling)
- [ ] [5: Memory, storage and I/O](#5-memory-storage-and-io)
- [ ] [6: Additional comments from submitter](#6-additional-comments-from-submitter)
- [ ] [7: Pre-assessment outcome](#7-pre-assessment-outcome)

## 1: Benchmark setup

### Fetch and build benchmarks

The submitter requested an assessment of `paboyle/Grid`, commit ID: 3232b438f2cf729e515c185e2dbf29d7cc276bb7 on the `develop` branch. We picked the most recent commit on the `develop` branch at the time of commencement of this pre-assessment. 

To obtain the benchmarks simply run:
```bash
git clone -b sunbird git@github.com:gray95/grid-benchmark.git
cd grid-benchmark
```

`systems/sunbird1` contains the files needed to compile `Grid` and the benchmarks. There are two build targets, `cpu`, and `gpu-a100`.

To build MPI-enabled `Grid` and its benchmarks for the cpu nodes we ran the following commands from within the top level of the cloned repository.
```bash
BENCH_ENV=/scratch/scw1019/GR/envGridBench
# create benchmark environment
./bootstrap-env.sh ${BENCH_ENV} sunbird1
# activate benchmark environment
source ${BENCH_ENV}/env.sh cpu
# build Grid
./build-grid.sh ${BENCH_ENV} cpu 32
# build benchmarks
./build-benchmark.sh ${BENCH_ENV} cpu 32 
```

`/scratch/scw1019/GR/envGridBench` is the folder into which the benchmark environment is installed.  Swapping out `cpu` for `gpu-a100` and re-running the above builds the benchmarks for the gpu nodes. The `cpu` build took about 10 minutes and the `gpu-a100` build took about HUH, before installing `Benchmark_Grid` and `Benchmark_IO` into  `${BENCH_ENV}/prefix/gridbench_cpu/bin`.

To run `Benchmark_Grid` on a single node with one MPI rank:
```bash
GRID_BENCH=${BENCH_ENV}/prefix/gridbench_cpu/bin/Benchmark_Grid
mpirun -np 1 ${GRID_BENCH} --mpi 1.1.1.1 --json-out results.json
```

`Benchmark_Grid` does not write any files to disk other than a `json` file at the end summarising the benchmark results. Typical size of these files: <>. It does write to the console, although the output is not especially large, a typical file will be about <>. The following console output is written for each lattice size:
```txt
Grid : Message : 12.985261 s : Benchmark SU(3) DWF on 24^4 local volume
Grid : Message : 12.985265 s : * Group family   : SU
Grid : Message : 12.985268 s : * Nc             : 3
Grid : Message : 12.985271 s : * Representation : Fundamental
Grid : Message : 12.985274 s : * Global volume  : 24 24 24 48
Grid : Message : 12.985282 s : * Ls             : 1
Grid : Message : 12.985285 s : * ranks          : 2
Grid : Message : 12.985288 s : * nodes          : 1
Grid : Message : 12.985291 s : * ranks/node     : 2
Grid : Message : 12.985294 s : * ranks geom     : 1 1 1 2
Grid : Message : 12.985297 s : * Using 20 threads
Grid : Message : 12.985300 s : ===============================================================================
Grid : Message : 13.104066 s : Initialised RNGs
Grid : Message : 15.614658 s : ------------------------------------------
Grid : Message : 15.614678 s : * Using GENERIC Nc Grid::WilsonKernels
Grid : Message : 15.614697 s : * Using sequential Comms/Compute
Grid : Message : 15.614701 s : * SINGLE precision
Grid : Message : 15.614705 s : ------------------------------------------
Grid : Message : 24.044987 s : Deo FlopsPerSite is 1344.0
Grid : Message : 24.045025 s : Deo Gflop/s =   27.0 (0.0) 24.6-27.4
Grid : Message : 24.045032 s : Deo Gflop/s per rank   13.5
Grid : Message : 24.045036 s : Deo Gflop/s per node   27.0
Grid : Message : 24.045040 s : ------------------------------------------
Grid : Message : 24.045043 s : * Using GENERIC Nc Grid::WilsonKernels
Grid : Message : 24.045061 s : * Using Overlapped Comms/Compute
Grid : Message : 24.045064 s : * SINGLE precision
Grid : Message : 24.045067 s : ------------------------------------------
Grid : Message : 32.980854 s : Deo FlopsPerSite is 1344.0
Grid : Message : 32.980886 s : Deo Gflop/s =   25.4 (0.0) 23.0-25.7
Grid : Message : 32.980893 s : Deo Gflop/s per rank   12.7
Grid : Message : 32.980896 s : Deo Gflop/s per node   25.4
Grid : Message : 32.980900 s : ------------------------------------------
Grid : Message : 32.980920 s : * Using GENERIC Nc Grid::WilsonKernels
Grid : Message : 32.980954 s : * Using sequential Comms/Compute
Grid : Message : 32.980957 s : * SINGLE precision
Grid : Message : 32.980960 s : ------------------------------------------
Grid : Message : 41.405917 s : Deo FlopsPerSite is 1344.0
Grid : Message : 41.405955 s : Deo Gflop/s =   27.0 (0.0) 23.9-27.4
Grid : Message : 41.405962 s : Deo Gflop/s per rank   13.5
Grid : Message : 41.405966 s : Deo Gflop/s per node   27.0
Grid : Message : 41.405970 s : ------------------------------------------
Grid : Message : 41.405973 s : * Using GENERIC Nc Grid::WilsonKernels
Grid : Message : 41.405992 s : * Using Overlapped Comms/Compute
Grid : Message : 41.405995 s : * SINGLE precision
Grid : Message : 41.405998 s : ------------------------------------------
Grid : Message : 50.357856 s : Deo FlopsPerSite is 1344.0
Grid : Message : 50.357890 s : Deo Gflop/s =   25.4 (0.0) 24.6-25.7
Grid : Message : 50.357911 s : Deo Gflop/s per rank   12.7
Grid : Message : 50.357915 s : Deo Gflop/s per node   25.4
Grid : Message : 50.357919 s : ------------------------------------------
Grid : Message : 50.357922 s : 24^4 Deo Best  Gflop/s        =   27.0 ; 27.0 per node
Grid : Message : 50.357943 s : 24^4 Deo Worst Gflop/s        =   25.4 ; 25.4 per node
Grid : Message : 50.357947 s : G/S/C ; G/O/C ; G/S/S ; G/O/S
Grid : Message : 50.357950 s : 27.0 ; 25.4 ; 27.0 ; 25.4 ;
```

### Reference architecture

These benchmarks have been used on a few other systems, some of which are similar to `Sunbird`. 
## 2: Description of working environment

### Hardware information

> [!IMPORTANT]
> Add the hardware information used, including where applicable the queue information if necessary. Comment on expected normal limit for the hardware, e.g. size of the largest interconnected set of nodes, or memory limitations. Compare with the reference architecture (if different), indicating any issues you may expect to see due to the differences.

#### SUNBIRD

The `Sunbird` system hosted at the __Swansea Academy of Advanced Computing__ was used for this assessment. Hardware details for `Sunbird` are [listed online here](https://portal.supercomputing.wales/index.php/about-sunbird/). This information is corroborated by the output of `cat /proc/cpuinfo` on one of the compute nodes via an interactive session. `Sunbird` has 122 CPU + 4 V100 GPU + 6 A100 GPU compute nodes. A newer GPU partition, [AccelerateAI](https://sa2c.swansea.ac.uk/AccelerateAI/sections/understanding),comprises six BullSequana X410-A5 nodes, connected to each other (and to `SUNBIRD`)  via NVIDIA Networking Infiniband EDR. 

There is a total of 808 TB of scratch space and 231 TB of home directory space on a Lustre filesystem. Individual users have up to 100 GB of home storage and 19 TB of scratch.
##### CPU nodes

| Specification | Per node                                                                                                                                                                       |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Processors    | 2$\times$ Intel [Xeon Gold 6148](https://www.intel.com/content/www/us/en/products/sku/120489/intel-xeon-gold-6148-processor-27-5m-cache-2-40-ghz/specifications.html)(Skylake) |
| L1/L2/L3      | 1.28/40/27.5 MB                                                                                                                                                                |
| Clock speed   | 2.40 GHz                                                                                                                                                                       |
| Sockets       | 2                                                                                                                                                                              |
| Cores         | 40                                                                                                                                                                             |
| Memory        | 384 GB DDR4                                                                                                                                                                    |
| NUMA regions  | 2, one each for the even and odd-numbered cores                                                                                                                                |
#### SUNBIRD2

#### CPU nodes

| Specification        | Per node                                                                                     |
| -------------------- | -------------------------------------------------------------------------------------------- |
| Processors           | 2$\times$ AMD EPYC 9555 (Zen5)                                                               |
| Sockets              | 2                                                                                            |
| Cores                | 128                                                                                          |
| Clock speed per CPU  | 2.3GHz                                                                                       |
| L1/L2/L3 cache sizes | 48kB/1MB/32MB                                                                                |
| Memory               | 768GiB                                                                                       |
| NUMA regions         | 8                                                                                            |
| Local storage        | <> of scratch space on a --- filesystem<br><> TB of home directory space on a --- filesystem |

Each core has two threads for a total of 256 hardware threads per node. Each node has 8 NUMA domains each serving 32 hardware threads (or, if you prefer, 16 cores). Five of the 51 nodes are high memory nodes with 1.5TiB of memory.

There are several Nvidia GPU partitions,

##### Hopper nodes

| Specification        | Per Node                                                                                                                                                                      |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GPUs                 | 4 x Nvidia H100 PCIe 80GB                                                                                                                                                     |
| Processors           | 2 x [Intel(R) Xeon(R) Gold 6330](https://www.intel.com/content/www/us/en/products/sku/212458/intel-xeon-gold-6330-processor-42m-cache-2-00-ghz/specifications.html) (Icelake) |
| Cores                | 56                                                                                                                                                                            |
| Clock Speed per CPU  | 2.00GHz                                                                                                                                                                       |
| L1/L2/L3 cache sizes | 2.625/70/42 MB                                                                                                                                                                |
| Memory               | 512 GB DDR4                                                                                                                                                                   |
| NUMA regions         | 2, for odd and even-numbered hardware threads                                                                                                                                 |
| Interconnects        | PCIe                                                                                                                                                                          |

##### Grace Hopper nodes:

| Specification        | Per Node                                                                                                   |
| -------------------- | ---------------------------------------------------------------------------------------------------------- |
| GPUs                 | 1 Nvidia [GH200](https://dam-cdn.nvd.orangelogic.com/AssetLink/tkno03fa645gb7f33w60rf200d330420.pdf) 480GB |
| Processors           | 1$\times$ Nvidia Grace CPU                                                                                 |
| Cores                | 72                                                                                                         |
| CPU Clock Speed      | 3.0GHz                                                                                                     |
| L1/L2/L3 cache sizes | 4.5/72/114MB                                                                                               |
| Memory               | 480GB LPDDR5X                                                                                              |
| NUMA regions         | 1                                                                                                          |
| Interconnect         | NVIDIA NVLink Chip-2-Chip (C2C)<br>                                                                        |
Notably this CPU is arm-based as opposed to the other x86_64 based partitions.

##### A100 GPU nodes

A holdover from the predecessor Sunbird system:
[AccelerateAI](https://sa2c.swansea.ac.uk/AccelerateAI/sections/understanding) comprises six BullSequana X410-A5 nodes, connected to each other (and to the Supercomputing Wales SUNBIRD hardware) via NVIDIA Networking Infiniband EDR. Within each node is:

| Specification       | Per Node                                                                                                                                                                                                                  |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GPUs                | 8$\times$ Nvidia [A100](https://www.nvidia.com/content/dam/en-zz/Solutions/Data-Center/a100/pdf/A100-PCIE-Prduct-Brief.pdf#%5B%7B%22num%22%3A19%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%22XYZ%22%7D%2C81%2C574%2C0%5D) 40GB |
| Processors          | 2$\times$ AMD [EPYC Rome 7452](https://chipswiki.org/Amd/epyc/7452) (Zen2)                                                                                                                                                |
| Sockets             | 2                                                                                                                                                                                                                         |
| Cores               | 64                                                                                                                                                                                                                        |
| L1/L2/L3            | 2/16/256 MB                                                                                                                                                                                                               |
| Clock Speed per CPU | 2.35 GHz                                                                                                                                                                                                                  |
| Interconnects       | 4$\times$ Nvidia NVLink bridges between pairs of GPUs<br>1$\times$ Nvidia Networking Infiniband EDR 100GB/s link                                                                                                          |
| Memory              | 512 GB DDR4                                                                                                                                                                                                               |
| NUMA nodes          | 8, each with 64GB RAM and 8 cores                                                                                                                                                                                         |

![[accelerate-ai-nodes.png|519]]

### Libraries and modules

> [!IMPORTANT]
> Provide information on the libraries that need to be installed or modules that must be loaded based on the compilation information provided by the submitter.

The provided setup scripts download and install [`pixi`](https://pixi.prefix.dev/latest/) , a package management tool, in order to create and manage the benchmark environment. `pixi` downloads and installs `Grid`, `lime` (a dependency needed for certain I/O functionality), and the benchmarks. The `systems/<machine>/files` folder contains machine-specific setup scripts, primarily this involves loading the correct system libraries, the compiler and MPI implementation. `Sunbird` uses the common `Lmod` module system to change the software environment. 
```text
$ module --help  
  
  Modules Release 3.2.10 2012-12-21 (Copyright GNU GPL v2 1991):
```

modules for cpu build:
```text
module load mpi/openmpi/4.1.6  
module load compiler/gnu/12/1.0
```

modules for gpu build:

Because of the rather outdated software stack on `Sunbird` we found that we needed to set the `pixi` environment variables `CONDA_OVERRIDE_CUDA=12` and `CONDA_OVERRIDE_GLIBC=2.28` _before_ running the setup scripts. 
### Assessment tools

> [!IMPORTANT]
>
> 1. Limit pre-assessment tools to those with very low runtime. Mostly just focus on whether the program is running as expected. Do not assess the results of the benchmark for correctness as that requires domain-specific knowledge.
> 2. High level assessment tools and techniques which are expected to be useful, like global measures such as wall time.

1. Pre-assessment:
    - `likwid-topology`
    - `nvidia-smi`
    - `Lmod` 

2. High-level assessment:
    - `likwid-bench` 
    - `valgrind`

## 3: Compiler setup and optimisations

> [!IMPORTANT]
> Based on the compilation information provided by submitter, comment on the following (where applicable):
>
> - package manager (e.g. `spack`)
> - build toolchain (e.g. `cmake`)
> - main compiler version (e.g. GCC 11)
> - compiler optimisations (e.g. -O3, `--fast-math`)
> - additional accelerator libraries and versions (e.g. SYCL revision 11, Kokkos 5.1)
> - any feature sets which are toggled on (e.g. vectorisation)
>
> Add additional information about the impact of optimisations on convergence or correctness of results if provided by the submitter. If there are any issues with compatibility on the machine you are testing on, or any build issues experienced, provide details.

Build instructions from the user `<build_toolchain>` to build the `<program_name>` with `<optimisation_level>`.

> [!tip]
> MAQAO should present missed compiler optimisation opportunities. Increasing the optimisation level may require re-converging the system to confirm accuracy. This may be outside the scope of the assessment.
## 4: Computational complexity and scaling

> [!IMPORTANT]
 Add any information provided by the submitter regarding the scaling of _computation (i.e. work)_,_memory_ and _execution time_ as the problem size or work units are increased.
>
> If there is existing scaling information (graphs or raw data) available, attach it to this report or add links to access it.

The `--max-L` flag takes a `size` value that sets the maximum lattice size for the flops benchmarks. This must either be a power of 2, or 3 times a power of 2. The default value of size (and the minimum value) = 32. The number of cores/GPUs can be changed via `slurm` in the usual way.  
## 5: Memory, storage and I/O

The benchmarks vary in size, with the smallest lattices occupying ~10MB of memory and the largest occupying 24GB of memory.

The benchmark repository, which includes the benchmark source code and the results from previous benchmarking runs is 311MB in size. Once installed the `pixi` environment containing `Grid`, its dependencies, and the benchmarks is 4.4GB.

`Benchmark_Grid` does not write any temporary files to disk. It writes a small log to `stdout` and a json file with the results upon completion.

`Benchmark_IO`, in its default configuration, writes a series of files to disk, `iobench_*.bin`, totalling 2.8 GB. Its console output per lattice:
```text
Grid : Message : 401.575353 s : ===============================================================================
Grid : Message : 401.575366 s : Pass 10/10
Grid : Message : 401.575372 s : ===============================================================================
Grid : Message : 401.575378 s : ------------------------------------------
Grid : Message : 401.575383 s : Benchmark std write
Grid : Message : 401.575388 s : ------------------------------------------
Grid : Message : 401.575394 s : -- Local volume 8^4
Grid : Message : 401.590232 s : Std I/O write: Data CRC32 1ce6652c
Grid : Message : 401.590915 s : Std I/O write: Wrote 1572864 bytes in 0.000664 s, 2259.03614 MB/s
Grid : Message : 401.590932 s : Std I/O write: checksum overhead 0.000610 s
Grid : Message : 401.592403 s : -- Local volume 10^4
Grid : Message : 401.627839 s : Std I/O write: Data CRC32 4a113ccb
Grid : Message : 401.629650 s : Std I/O write: Wrote 3840000 bytes in 0.001781 s, 2056.20964 MB/s
Grid : Message : 401.629670 s : Std I/O write: checksum overhead 0.001441 s
Grid : Message : 401.632080 s : -- Local volume 12^4
Grid : Message : 401.702436 s : Std I/O write: Data CRC32 c6df5427
Grid : Message : 401.706248 s : Std I/O write: Wrote 7962624 bytes in 0.003781 s, 2008.39725 MB/s
Grid : Message : 401.706270 s : Std I/O write: checksum overhead 0.002705 s
Grid : Message : 401.709464 s : -- Local volume 14^4
Grid : Message : 401.838818 s : Std I/O write: Data CRC32 1746dd54
Grid : Message : 401.846915 s : Std I/O write: Wrote 14751744 bytes in 0.008062 s, 1745.02101 MB/s
Grid : Message : 401.846939 s : Std I/O write: checksum overhead 0.004830 s
Grid : Message : 401.852341 s : -- Local volume 16^4
Grid : Message : 402.070869 s : Std I/O write: Data CRC32 ef882fc7
Grid : Message : 402.084524 s : Std I/O write: Wrote 25165824 bytes in 0.013619 s, 1762.24392 MB/s
Grid : Message : 402.084547 s : Std I/O write: checksum overhead 0.008189 s

```

```json
    "av_grid_read_mean": 652.0404257147627,
    "av_grid_read_rob": 98.41002010222904,
    "av_grid_read_stddev": 10.36731169420494,
    "av_grid_write_mean": 364.0086517661443,
    "av_grid_write_rob": 87.3428391578875,
    "av_grid_write_stddev": 46.07316053324606,
    "av_max_L": 32,
    "av_min_L": 24,
    "av_std_read_mean": 4890.250109869353,
    "av_std_read_rob": 98.62863490592967,
    "av_std_read_stddev": 67.06318301948433,
    "av_std_write_mean": 2066.8813701613326,
    "av_std_write_rob": 98.89826606721044,
    "av_std_write_stddev": 22.771533405573162,
```
## 6: Additional comments from submitter

### Benchmark provenance
The benchmarks we've used were developed for the UKRI Living Benchmarks project.
`Grid` can be fetched as follows:
```bash
git clone git@github.com:paboyle/Grid.git
git checkout 3232b438
```
But we _did not need to do this manually_, the scripts included with the benchmark source code will clone the repository for us - all we need to do is provide a commit ID for the version of `paboyle/Grid` we wish to benchmark. 

### Sub-benchmarks
`Benchmark_Grid`contains many sub-benchmarks, each targetting a different aspect of the `Grid` library.  These sub-benchmarks target
- _memory bandwidth_
- _inter-process bandwidth_ 
- _floating point performance_
- _Peer-to-Peer latency_ (OFF by default)
- _Peer-to-Peer bandwidth_ (OFF by default)

The memory bandwidth and inter-process bandwidth benchmarks can be disabled with `--no-benchmark-memory/comms` flags and the flops benchmark can be scaled back in a similar way. A core set of benchmarks involving the Wilson, domain-wall, and staggered solvers are not able to be switched off.

The benchmarks output their own statistics. For instance the FLOPS benchmarks write a summary table like so: [insert table here]

### Internet access

The various build scripts pull code from the internet so the node on which it is run needs to be able to connect online.

### Filesystem/`pixi` issues
`Sunbird`'s filesystem had difficulty handling `pixi`'s solver,
```shell
Error:   × failed to link liblzma-5.8.3-hb03c661_1.conda  
 ├─▶ failed to link 'lib/liblzma.so.5.8.3'  
 ├─▶ failed to copy file to destination  
 ╰─▶ failed to copy file from `/scratch/scw1019/GR/.pixi_cache/pkgs/liblzma-5.8.3-hb03c661_1/lib/liblzma.so.5.8.3` to `/scratch/scw1019/GR/envGridBench1/.pixi/envs/gpu-nvidia/lib/liblzma.so.5.8.3`: Cannot send after socket shutdown (os error 108)
```
This significantly lengthened the time required to carry out this pre-assessment.
### Serial build failure
I attempted a serial build by passing the `--enable-communications=none` configure flag. As expected `Grid` built just fine but the benchmarks did not compile. This is because the benchmark code uses MPI functions.
```shell
error: ‘MPI_COMM_WORLD’ was not declared in this scope  
 327 |     MPI_Comm_rank(MPI_COMM_WORLD, &me);
```

`accelerate_ai` nodes use cpus which do not support AVX512 so care must be taken to use an MPI compiled for AVX2.

```shell
/scratch/scw1019/GR/envGridBenchDebugGpu/build/Grid/gpu-a100/Grid/Eigen/src/Core/arch/AVX/PacketMath.h  
(984): warning #68-D: integer conversion resulted in a change of sign
```

The memory bandwidth and inter-process bandwidth benchmarks can be disabled with `--no-benchmark-<>` flags and the flops benchmark can be scaled back in a similar way. A core set of benchmarks involving the Wilson, domain-wall, and staggered solvers are not able to be disabled.

The provided benchmarks output their own statistics. For instance the FLOPS benchmarks write a summary table like so: [insert table here]

For `Benchmark_IO` to work it needs a folder `io/` in the current working directory otherwise no files are written to disk.
## 7: Pre-assessment outcome

__YES__. 

The `Sunbird` system was decomissioned on the 28th of October 2026. A new pre-assessment was carried out on the successor `Sunbird2` system. The `accelerate_ai` partition will be carried over but the rest of the hardware and software stack have been updated to a more modern standard.