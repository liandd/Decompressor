#!/bin/bash

name_decompressed=$(7z l content.gzip | grep "Name" -A 2 | tail -n 1 | awk 'NF{print $NF}')
7z x  content.gzip > /dev/null 2>&1

while true; do
	7z l $name_decompressed > /dev/null 2>&1
	if [ "$(echo $?)" == "0" ]; then
		decompressed_next=$(7z l $name_decompressed | grep "Name" -A 2 | tail -n 1 | awk 'NF{print $NF}')
		7z x $name_decompressed > /dev/null 2>&1 && name_decompressed=$decompressed_next
	else
		cat $name_decompressed; rm data* 2>/dev/null
		exit 1
	fi
done
