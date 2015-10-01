#!/bin/bash

preflight_test () {
    # test filesystem type
    path=${2:-/srv}
    fstype=${3:-ext4}
    fstype2=$4

    cur_fstype=$(mount | grep " $path " | awk '{ print $5 }')

    if [ "$cur_fstype" == "$fstype" -o "$cur_fstype" == "$fstype2" ]; then
        output_ok "Filesystem Type ( $path | $fstype,$fstype2/$cur_fstype )"
    else
        output_fail "Filesystem Type ( $path | $fstype/$cur_fstype )"
    fi
}
