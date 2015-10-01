#!/bin/bash
# preflight for softlayer db nodes (smb)

if [ -f "$(dirname $0)/util.bash" ]; then
    source "$(dirname $0)/util.bash"
else
    curl -s -O "https://raw.githubusercontent.com/cloudant/preflight/master/util.bash"
    source util.bash
    rm util.bash
fi

# test root disk
run_test "disk_space" "/" 9500000
run_test "filesystem_type" "/" "ext3" "ext4"

# test data disk
run_test "device_size" "/dev/sda7" 700000000
# check if /srv mounted
if mount | grep "/srv" > /dev/null; then
    run_test "filesystem_type" "/srv" "ext4"
fi

# test total memory (MB)
run_test "memory" 16000

# test CPU total (cores)
run_test "cpu" 4

# test CPU Type
run_test "cpu_type" "E3-1270"

# test network (nics and bonds)
run_test "network" 4 2

# test jumbo frames
run_test "jumbo_frames" "lb1.meritage.cloudant.net"

# test OS
run_test "os"

# clean os
run_test "clean_os"

exit_now
