#!/bin/bash

preflight_test () {
    # test device size

    if [ -z $2 ]; then
        path="/dev/sda"
    else
        path=$2
    fi

    if [ -z $3 ]; then
        size=9000000
    else
        size=$3
    fi

    if [ -b $path ]; then
        r=$(blockdev --getsize64 $path)
        if [ $size -gt $r ]; then
            output_fail "Device Size ( '$path' | $size/$r Bytes )"
        else
            output_ok "Device Size ( '$path' | $size/$r Bytes )"
        fi
    else
        output_fail "Device Size ( '$path' | $size/$r Bytes )"
        echo "$path does not exist" | red
    fi
}
