#!/bin/bash

preflight_test () {
    # test disk size

    if [ -z $2 ]; then
        path="/"
    else
        path=$2
    fi

    if [ -z $3 ]; then
        size=9000000
    else
        size=$3
    fi

    if [ -d $path ]; then
        r=$(df | grep " $path$" | awk '{ print $2 }' | head -1)

        if [ -z "$r" ]; then
            output_fail "Disk path not found - Disk Size ( '$path' | $size/$r KB )"
        elif [ $size -gt $r ]; then
            output_fail "Disk Size ( '$path' | $size/$r KB )"
        else
            output_ok "Disk Size ( '$path' | $size/$r KB )"
        fi
    else
        output_fail "Disk Size ( '$path' | $size/$r KB )"
        echo "Disk path does not exist" | red
    fi
}
