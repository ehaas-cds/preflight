#!/bin/bash

preflight_test () {
    # test network

    if [ -z $2 ]; then
        nics=4
    else
        nics=$2
    fi

    if [ -z $3 ]; then
        bonds=2
    else
        bonds=$3
    fi

    if [ -z `which ifconfig` ]; then
        output_fail "Could not find 'ifconfig' command"
    elif [ -z `which ip` ]; then
        output_fail "Could not find 'ip' command"
    else
        availPorts=$(ip link show | egrep "^?: eth" | wc -l)
        availBonds=$(ip link show | egrep "^?: bond" | wc -l)

        confgPorts=$(ifconfig -s | grep "^eth" | wc -l)
        confgBonds=$(ifconfig -s | grep "^bond" | wc -l)

        status="Network ($nics/$availPorts/$confgPorts target/avail/confg | $bonds/$availBonds/$confgBonds target/avail/confg)"

        if [[ $availPorts -lt $nics ||
              $confgPorts -lt $nics ||
              $availBonds -lt $bonds ||
              $confgBonds -lt $bonds ]]; then
            output_fail "$status"
        else
            output_ok "$status"
        fi
    fi
}
