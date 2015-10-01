#!/bin/bash

preflight_test () {
  # test OS; should be debian 6 or 7 or ubuntu 12.04 or 14.04
  if lsb_release > /dev/null 2>&1; then
    distribution=$(lsb_release -i | awk '{ print $NF }')
    version=$(lsb_release -r | awk '{ print $NF }')
    deb_version=$(echo $version | head -c1)

    if [ "$distribution" == "Ubuntu" -a \( "$version" == "12.04" -o "$version" == "14.04" \) ]; then
      output_ok "Operating System"
    elif [ "$distribution" == "Debian" -a \( "$deb_version" == "6" -o "$deb_version" == "7" \) ]; then
      output_ok "Operating System"
    else
      output_fail "Operating System"
    fi
  else
    output_fail "Operating System"
  fi
}
