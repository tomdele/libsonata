
#!/bin/bash

export INPUT_FILE=/gpfs/bbp.cscs.ch/data/scratch/proj83/home/bolanos/circuits/Bio_M/20200731/testsims/test008/soma_test/soma.h5_sonata_None_None.h5
export DARSHAN_ENABLE_NONMPI=1
export DARSHAN_OUTPUT_DIR=/gpfs/bbp.cscs.ch/data/scratch/proj16/srivas/libsonata/performance

function run_test {
    start_time=`date +%s`
    srun -n 1 env LD_PRELOAD=$DARSHAN_DIR/lib/libdarshan.so python launch.py $1 $2 $3 $4 $INPUT_FILE 1>/dev/null 2>/dev/null
    elapsed=$((`date +%s` - start_time))
    mv *_python_id*.darshan libsonata_$1\_$2\_$3\_$4.darshan
    rm core.* # For Darshan

    echo "$1; $2; $3; $4; $elapsed; $INPUT_FILE"
}

for nsamples in 10 100 1000 10000 100000
do
   run_test 50001  150000  $nsamples 1
   run_test 250001 750000  $nsamples 1
   run_test 1      1912450 $nsamples 1
done

for stride in 1 10 100 1000 10000
do
   run_test 1 1912450 1000000 $stride
done

