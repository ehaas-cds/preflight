#!/bin/bash

# CPU number of cores
PF_BI_NUM_CORES=16
export PF_BI_NUM_CORES

# CPU type
PF_BI_CPU_TYPE="E5-2650"
export PF_BI_CPU_TYPE

# RAM (MB)
PF_BI_RAM=128000
export PF_BI_RAM

# Num of data disks, set 0 for management nodes
NUM_DATA_DISKS=7
export NUM_DATA_DISKS

PF_BI_PARTITION_DETAILS="/var 950 /boot 1 /opt 950 /home 950 /tmp 1450 /bigsqlhome 950 / 500"
export PF_BI_PARTITION_DETAILS

if [ -f "$(dirname $0)/ehaas_template.bash" ]; then
    bash ./ehaas_template.bash
else
    curl -s https://raw.githubusercontent.com/ehaas-cds/preflight/master/ehaas_template.bash | bash
fi
