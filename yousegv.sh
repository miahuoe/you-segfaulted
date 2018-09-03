#!/usr/bin/bash

if [ $# -lt 1 ] ; then
	echo "Usage: $0 <video-to-play>"
	exit
fi

function extract_timestamp {
	tail -1 | cut -d '[' -f 2 | cut -d '.' -f 1
}

recent=$(dmesg | extract_timestamp)
sleep 1

dmesg -w | while read LINE
do
	t=$(echo "$LINE" | extract_timestamp)
	if [ $t -gt $recent ] ; then
		mpv --fs "$1"
		recent=$t
	fi
done
