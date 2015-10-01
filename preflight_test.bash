#!/bin/bash

# test RAID config
preflight_test () {
    if [ -f /usr/StorMan/arcconf ] || [ -f /usr/Adaptec_Event_Monitor/arcconf ] ; then
        raid_fail=1
        if [ -f /usr/Adaptec_Event_Monitor/arcconf ]; then
            arcconf=/usr/Adaptec_Event_Monitor/arcconf
        else
            arcconf=/usr/StorMan/arcconf
        fi

        # check for raid 10 or raid 1
        r=$($arcconf getconfig 1 ld | grep "RAID level" | awk '{ print $NF }' | head -1 )
        if [ ! $r -eq 10 ] && [ ! $r -eq 1 ]; then
            raid_fail=0
        fi

        if [ "$2" != "sdp" ]; then
          # check for raid 0
          r=$($arcconf getconfig 1 ld | grep "RAID level" | awk '{ print $NF }' | tail -1 )
          if [ ! $r -eq 0 ]; then
              raid_fail=0
          fi
        fi

        if [ $raid_fail -eq 0 ]; then
            output_fail "RAID Configuration"
          else
            output_ok "RAID Configuration"
        fi

        # Skipping ZMM test because nodes should now have write-caching turned off,
        # at least for SSD nodes. See https://cloudant.fogbugz.com/f/cases/32602.
        # In the future, we need to check if it's on or off depending on the type
        # of disk.
        echo "SKIPPING ZMM TEST"
        # test ZMM
        # r=$($arcconf getconfig 1 | egrep -i '(zmm|write-cache)' | egrep '(ZMM Optimal|: On)')
        # if [ $? -eq 0 ]; then
        #     output_ok "ZMM Status"
        # else
        #     output_fail "ZMM Status"
        # fi
    elif [ -f /proc/mdstat ]; then
        # using software RAID
        if grep '^md2 : active raid0 ' /proc/mdstat > /dev/null && grep '^md0 : active raid1 ' /proc/mdstat > /dev/null; then
            output_ok "RAID Configuration"
        else
            output_fail "RAID Configuration"
        fi
    else
        output_fail "RAID Configuration"
        echo "Unable to find RAID cli tool" | red
    fi
}
