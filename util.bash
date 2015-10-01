#!/bin/bash
# shared functions and variables

base_url="https://raw.githubusercontent.com/ehaas-cds/preflight/master"

success=0

run_test () {
    if [ -f "$(dirname $0)/tests/$1.bash" ]; then
        source "$(dirname $0)/tests/$1.bash"
        preflight_test $@
    else
        curl -o "preflight_test.bash" -s "$base_url/tests/$1.bash"
        source preflight_test.bash
        preflight_test $@
        rm preflight_test.bash
    fi
}

output_ok () {
  echo "$1.... OK" | green
}

output_fail () {
  echo "$1.... Fail" | red
  success=1
}

black () { color_text 30; }
blue () { color_text 34; }
green () { color_text 32; }
cyan () { color_text 36; }
red () { color_text 31; }
purple () { color_text 35; }
brown () { color_text 33; }
light_gray () { color_text 37; }

color_text () {
  while read data; do echo -e "\033[$1m$data"; done
  echo -e -n "\033[0m" # clear the color
}

exit_now () {
  exit $success
}
