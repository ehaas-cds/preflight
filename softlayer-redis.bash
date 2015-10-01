#!/bin/bash
# preflight for softlayer lb nodes

if [ -f "$(dirname $0)/util.bash" ]; then
    source "$(dirname $0)/util.bash"
else
    curl -s -O "https://raw.githubusercontent.com/cloudant/preflight/master/util.bash"
    source util.bash
    rm util.bash
fi

# No RAID on SAPI Redis nodes
# run_test "RAID"

# test root disk
run_test "disk_space" "/" 500000000
run_test "filesystem_type" "/" "ext3" "ext4"

# test total memory (MB)
run_test "memory" 7900

# test CPU total (cores)
run_test "cpu" 4

# test network (nics and bonds)
run_test "network" 4 2

# test jumbo frames
run_test "jumbo_frames" "lb1.meritage.cloudant.net"

# test OS
run_test "os"

# clean os
run_test "clean_os"

exit_now
