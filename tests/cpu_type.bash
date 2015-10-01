#!/bin/bash

preflight_test () {
    # test CPU type

    r=$(cat /proc/cpuinfo | grep 'model name' | grep '$2' | wc -l)
    if [ 0 -gt $r ]; then
        output_fail "CPU Type"
    else
        output_ok "CPU Type"
    fi
}
