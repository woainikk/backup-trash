#!/bin/bash
fileName=$1
answer=0
answerToRename=0
[ $# -eq 0 ] && exit
cd ~/
alllog="$(cat ".trash.log")"
echo "" > .trash.log

for i in $alllog
do
	if [[ "$i" =~ "$fileName:" ]]
	then
		echo "Do you want to restore $i? Yes\No"
		read answer
		if [ $answer = "Yes" ]
		then
		cd ~/.trash		
		fileInTrash="$( echo "$i" | cut -d ":" -f 2 )"
		mycd="$(echo "$i" | cut -d ":" -f 1 | grep -oP ".*/")"
			if [ ! -f $mycd$fileName ]
			then 
			ln -- "$fileInTrash" "$mycd$fileName"
			rm -- "$fileInTrash"
				else
				echo "This file already exists. Do you want to rename it with adding id? Yes/No. Else file will not be restored."
				read answerToRename
					if [ $answerToRename = "Yes" ]
					then ln -- "$fileInTrash" "$mycd$fileName$fileInTrash"
					rm -- "$fileInTrash"
					fi
			fi
		
		fi 
	cd ~/
	else echo "$i" >> .trash.log
	fi
done



		
		
	
		

