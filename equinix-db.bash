#!/bin/bash
# preflight for rackspace db nodes

if [ -f "$(dirname $0)/util.bash" ]; then
    source "$(dirname $0)/util.bash"
else
    curl -s -O "https://raw.githubusercontent.com/cloudant/preflight/master/util.bash"
    source util.bash
    rm util.bash
fi

# test raid
#run_test "RAID"
echo "SKIPPING RAID TEST"

# test root disk
run_test "disk_space" "/" 2000000000
run_test "filesystem_type" "/" "ext3" "ext4"

# test srv disk
run_test "disk_space" "/srv" 14000000000
run_test "filesystem_type" "/srv" "xfs" "ext4"

# test total memory (MB)
run_test "memory" 190000

# test CPU total (cores)
run_test "cpu" 32

# test network (nics and bonds)
run_test "network" 1 0

# test jumbo frames
run_test "jumbo_frames" "10.10.11.12"

# test OS
run_test "os"

# clean os
run_test "clean_os"

# test hostname/dns
run_test "dnsdomainname"

exit_now
