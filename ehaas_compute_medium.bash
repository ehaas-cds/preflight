#!/bin/bash
# preflight for softlayer db node

if [ -f "$(dirname $0)/util.bash" ]; then
    source "$(dirname $0)/util.bash"
else
    curl -s -O "https://raw.githubusercontent.com/ehaas-cds/preflight/master/util.bash"
    source util.bash
    rm util.bash
fi

# check if RHEL is registered
run_test "RHEL_subscription"

# test CPU total (cores)
run_test "cpu" 16

# test CPU Type
run_test "cpu_type" "E5-2650"

# test total memory (MB)
run_test "memory" 64000

# test raid
run_test "RAID"

# test data disk (KB)
num_of_disks=7
for i in `seq 1 $num_of_disks`;
do
	run_test "disk_space" "/disk"$i 3600000000
done

#run_test "filesystem_type" "/" "ext3" "ext4"

# test network (nics and bonds) ('yum install net-tools' is required for ifconfig)
run_test "network" 4 2

# test srv device
#run_test "device_size" "/dev/sdb" 1500000000000
# check if /srv mounted
#if mount | grep "/srv" > /dev/null; then
#    run_test "filesystem_type" "/srv" "ext4"
#fi

# test jumbo frames
#run_test "jumbo_frames" "lb1.meritage.cloudant.net"

# test OS
#run_test "os"

# test OS disk (GB)
#test partition spaces
run_test "partition_space" "/var" 950 "/boot" 1 "/swap" 128 "/opt" 950 "/home" 950 "/tmp" 1450 "/bigsqlhome" 950 "/" 500

# clean os
run_test "clean_os"

exit_now
