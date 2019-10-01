#!/bin/bash

# Author: Sarah Barron
# Computer Systems and Networking - Week 4 - Lab 2(5)

# Description: This script accepts 2 command line arguments the first argument is 
# a filename and the second argument is a MAC address
# The program then checks if the MAC address was a source address of ethernet frames


if [ $# -ne 2 ]
then
	echo "Please enter 2 command line arguments"
	echo "argument 1 should be the pcap file you want to check"
	echo "argument 2 should be the MAC address you want to check for"
	echo  $0 file.pcap  MAC address

else
# command  reads in the first argument which is the file to be used
# It filters the 5th column of the file which is the MAC address column
# It searches for the 2nd argument which is the MAC address in column 5
# It only returns 1 instance of if more than 1 match is found
# finally it removes the brackets and comma that surrounds the MAC address
	command=$(tshark -r $1 -T fields -e eth | awk '{print $5}' | grep $2 | uniq | sed 's/),$//;s/^(//')

#check if the return from the command matches the MAC argument
	if [ "$command" == "$2" ]
	then
		echo
		echo "CONFIRMED"
		echo	
		echo "The dbserver MAC: $2 is a src address of ethernet frames"
		echo "in the file $1"\n
		echo
	else
		echo
		echo "NO MATCH"
		echo
		echo "The dbserver MAC: $2 is NOT a src address of ethernet frames"
		echo "in the file $1"
		echo
	fi
fi
