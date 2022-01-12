#!/bin/bash

file=swapfile
grep -q "$file" /etc/fstab
creaetefile=$(dd if=/dev/zero of=/$file count=4096 bs=1MiB)

if [[ $? -ne 0 ]]; then
	echo "swapfile not found. Creating a swapfile..."
sleep 2
	$createfile
	chmod 0600 $file
	mkswap $file
	swapon $file
	echo "Setting $file on /etc/fstab file configuration"
sleep 2
	echo "$file none defaults 0 0" >> /etc/fstab
else
	echo "$file found. No changes made."
fi

sleep 2

	echo "checking $file created"
	swapon -s
	free -h

