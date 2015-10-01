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
# TODO implement PERC5 based RAID test for RAX
#run_test "RAID"
echo "SKIPPING RAID TEST"

# check device size
run_test "device_size" "/dev/sdb" 1500000000000

# test root disk
run_test "disk_space" "/" 9000000
run_test "filesystem_type" "/" "ext3" "ext4"

# test srv disk (if mounted)
if mount | grep "/srv" > /dev/null; then
    run_test "filesystem_type" "/srv" "ext4"
fi

# test total memory (MB)
run_test "memory" 64000

# test CPU total (cores)
run_test "cpu" 16

# test CPU type
run_test "cpu_type" "E5645"

# test network (nics and bonds)
run_test "network" 1 0

# test OS
run_test "os"

# clean os
run_test "clean_os"

# test hostname/dns
run_test "dnsdomainname"

exit_now
