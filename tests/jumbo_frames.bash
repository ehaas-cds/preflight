#!/bin/bash

# must pass paramter (as $2) for remote node to test jumbo frames

preflight_test () {
    # test jumbo frames

    if [ -z $2 ]; then
        output_fail "Jumbo frames"
        echo "No remote server to test jumbo frames against" | red
    else
        r=$(ping -c 3 -s 9000 $2)
        if [ $? -eq 0 ]; then
            output_ok "Jumbo frames"
        else
            output_fail "Jumbo frames"
        fi
    fi
}
