#!/bin/bash

####################################
# Autor: Gustavo Nogueira
# Systems/Server health Team
###################################

### Variables ###

UUIDSWAP=$(blkid | grep swap | cut -d" " -f2 | tr -d "\"")

# does the swap file already exist?
grep -q "swap" /etc/fstab

# if not exist swap in /etc/fstab create it

if [[ $? -ne 0 ]]; then

clear

	echo "finding UUID $UUIDSWAP from swap memory..."
sleep 3
	echo "Mounting $UUIDSWAP In the System..."
	swapon -a 

sleep 3
	echo "Configuring at /etc/fstab"
	echo "$UUIDSWAP swap swap defaults 0 0" >> /etc/fstab
	echo "The fstab was configurated"
sleep 3	
	cat /etc/fstab | grep -E 'swap|UUID' | sed '1d'

else
	echo "remove the line swap from the /etc/fstab."
	sed -i '10d' /etc/fstab

fi

sleep 3
	echo "checking the configuration"
	blkid | grep swap
	swapon -a
	free -h
	cat /proc/swaps
