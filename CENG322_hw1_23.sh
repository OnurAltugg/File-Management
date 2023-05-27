#!/bin/bash
#Group 23
#Fatih Kırçicek 260201016
#Onur Altuğ Akça 260201060

create_found () {
	mkdir Found
	if [ -d "$1" ]
	then
		grep -rl "$2" "$1" | xargs -I{} cp {} Found
	fi
	
	if [ "$(ls -A Found)" ]
	then
	    for file in Found/*
	    do
	    	mv "$file" Found/"found_$(basename "$file")"
	    done
	    echo "Files were copied to the Found directory!"
	    show_modifications
	    echo "Found"
	    for file in Found/*
	    do
	    	echo "	$(basename "$file")"
	    done
	else
	    echo "Keyword not found in files!"
	    rm -r Found
	fi
}	

show_modifications () {
	counter=1
	for file in Found/*
	do
	    echo "File$counter: $(basename "$file") was modified by $(stat -c "%U" "$file") on $(date -r $file "+%B %d, %Y") at $(date -r $file "+%H.%M")."
	    echo "File$counter: $(basename "$file") was modified by $(stat -c "%U" "$file") on $(date -r $file "+%B %d, %Y") at $(date -r $file "+%H.%M")." >> Found/modification_details.txt
	    counter=$((counter+1))
	done	
}

read -p "Enter the name of the directory: " dir_name
read -p "Enter the keyword: " key_name

create_found ${dir_name} ${key_name}
