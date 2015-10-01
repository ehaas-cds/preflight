#!/bin/bash

preflight_test () {
  # test OS is clean
  if [ -f /usr/local/etc/provider ]; then
    output_fail "Dirty OS"
  else
    output_ok "Clean OS"
  fi
}
