#!/bin/bash

preflight_test () {
	
	# check for sudo access
	#sudo -n true # do not check for sudo access - fails with the error 'sudo: sorry, you must have a tty to run sudo' even though subscription-manager list works fine
	#has_sudo_access=$? # 0 -> has access 1 -> no access

	subscription_status="No Sudo Access"
	# check if RHEL is registered
	#if [ $has_sudo_access -eq 0 ]; then
	  subscription_status=$(subscription-manager list | grep Status: | awk 'NR==1{print $2}' | tr -d ' ')
	#else
	#  subscription_status="No Sudo Access"
	#fi

	if [ "$subscription_status" = "No Sudo Access" ]; then
	  output_fail "Current user does not have Sudo Access to check RHEL Subscription"
	elif [ "$subscription_status" = "Subscribed" ]; then
	  output_ok "RHEL is registered with Red Hat Subscription Management"
	else
	  output_fail "RHEL is not registered with Red Hat Subscription Management"
	fi

}