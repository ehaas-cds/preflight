#!/bin/bash

preflight_test () {
    # test disk size

    expected_number_of_disks=$2

    expected_size=$3

    actual_number_of_disks=$(lsblk -b | grep -v sda | grep part | awk '{ print $4 }' | wc -l)

    if [ -z "$actual_number_of_disks" ]; then
        output_fail "Data Disks not found"
    elif [ $expected_number_of_disks -gt $actual_number_of_disks ]; then
        output_fail "Data Disks missing, found '$actual_number_of_disks', expected '$expected_number_of_disks'"
    else
        output_ok "'$actual_number_of_disks' Data Disks Found"
    fi

    for x in $(lsblk -b | grep -v sda | grep part | awk '{ print $4 }'); do 
        actual_size=$x

        if [ -z "$actual_size" ]; then
            output_fail "Data Disk size not available"
        elif [ $expected_size -gt $actual_size ]; then
            output_fail "Data Disks size not as expected, found '$actual_size', expected '$expected_size'"
        else
            output_ok "'$actual_size' - Data Disk with size found"
        fi
    done

    
}
