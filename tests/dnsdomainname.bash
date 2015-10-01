#!/bin/bash

preflight_test() {
  NAME='dnsdomainname'

  dnsdomainname > /dev/null && output_ok "$NAME" || output_fail "$NAME"
}
