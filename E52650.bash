#!/bin/bash
# preflight to check cpu_type

if [ -f "$(dirname $0)/util.bash" ]; then
    source "$(dirname $0)/util.bash"
else
    curl -s -O "https://raw.githubusercontent.com/cloudant/preflight/master/util.bash"
    source util.bash
    rm util.bash
fi

# test CPU Type
run_test "cpu_type" "E5-2650"

exit_now
