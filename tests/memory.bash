#!/bin/bash

preflight_test () {
    # test amount of ram

    if [ -z $2 ]; then
        total=8000
    else
        total=$2
    fi

    r=$(free -m | grep "Mem:" | awk '{ print $2 }')
    if [ $total -gt $r ]; then
        output_fail "Memory ($total/$r MB)"
    else
        output_ok "Memory ($total/$r MB)"
    fi
}
