#!/bin/bash

list_dir() {
	local base_url=$1
	curl -s $base_url | grep -oP '(?<=href=")([a-zA-Z/]*)' |
	while read dir
	do
		local dir_url="$base_url/$dir"
		local content_type=$(curl -sI $dir_url | grep -oP '(?<=Content-Type: )[a-zA-Z/]*')
		if [ "$content_type" = 'text/html' ]
		then
			list_dir $dir_url
		else
			local content="$(curl -s $dir_url)"
			echo "$dir_url : $content"
		fi
	done
}

list_dir $@
