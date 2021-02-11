#!/bin/bash

INTERFACE=eth0
MACBASE=00:24:4c:00:00:

count=0

while [ $count -le 40 ]
do
	# get value of last octet as a string
 	oct=$(printf "%02x" $count)

	# bring interface down, change mac 
	ifconfig $INTERFACE down
	macchanger -m ${MACBASE}${oct} $INTERFACE > /dev/null
	
	if [ $? -eq 0 ]; then
		echo "MAC:" $MACBASE$oct

		# bring the interface up
		ifconfig $INTERFACE up

		# wait for dhcp request and offer
		printf "Waiting"
		DELAY=15
		while [ $DELAY -gt 0 ]
		do
			printf "."
			sleep 1
			((DELAY--))
		done
		printf "\n"

		# check state of interface
		ifconfig eth0 | grep -w 'inet'
	fi

	((count++))
done


