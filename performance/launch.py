import libsonata
import numpy
import sys
import time
import random

int_min     = int(sys.argv[1])
int_max     = int(sys.argv[2])
nsamples    = int(sys.argv[3])
stride      = int(sys.argv[4])
report_path = str(sys.argv[5])

# This is to avoid an issue with the random sampler
int_init = 0
if (int_max - int_min) < nsamples:
    int_init = -1

random.seed(921)

gids = random.sample(range(int_min + int_init, int_max), nsamples)
gids[0]  = int_min
gids[-1] = int_max

elements = libsonata.ElementReportReader(report_path)

# open population
population_elements = elements[elements.get_population_names()[0]]

data_frame = population_elements.get(node_ids=gids, tstride=stride)
# print(data_frame.data)

