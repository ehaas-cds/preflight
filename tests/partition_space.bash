#!/bin/bash

preflight_test () {
    #test partitions size
    args=("$@")
	for ((i=1;i<$#;i=i+2)); do
		part_name=${args[i]}
		part_size=${args[i+1]}
		if [ -d $part_name ]; then
			r=$(df -BG | grep ^/dev/sda | grep " $part_name$" | awk '{ print $2 }' | head -1)

			r=${r//[G]/}; # remove the G from the value
			
			if [ -z "$r" ]; then
				output_fail "Partition not found - ( '$part_name' | $part_size GB )"
			elif [ $part_size -gt $r ]; then
				output_fail "Partition Size ( '$part_name' | $part_size/$r GB )"
			else
				output_ok "Partition Size ( '$part_name' | $part_size/$r GB )"
			fi
		else
			output_fail "Partition not found - ( '$part_name' | $part_size GB )"
	    	fi
	done
}
