#!/bin/bash
cd /home/margarita
dateFiles="$(ls | grep -E "^Backup-" | sort -n | tail -1 | cut -d "-" -f 2,3,4)"
ifCanmkdir=0
dateNow="$(date +%Y-%m-%d)" 

secondsPrev="$(date -d "$dateFiles" +%s)"
secondsNow="$(date -d "$dateNow" +%s )"
let ifCanmkdir=($secondsNow-$secondsPrev)/60/60/24

if [[ $ifCanmkdir -gt 7 ]]
then
	mkdir "Backup-$dateNow"
	cd ~/source 
	listInSource="$(ls)"
	echo "$listInSource"
		for i in $listInSource
		do
		cp -R $i $HOME/Backup-$dateNow
		done
	cd $HOME
	echo "Directory Backup-$dateNow was created. Files: $listInSource" >> backup-report
else
cd ~/source 
listInSource="$(ls)"
cd $HOME/Backup-$dateFiles
	for i in $listInSource
	do
		if [ -f "$i" ]
		then
		sizeInSource="$(ls -l -- ~/source/$i | awk '{print$5}')"
		sizeInBackup="$(ls -l $i | awk '{print$5}')"
			if [[ $sizeInSource -ne $sizeInBackup ]]
			then 
			mv $i $i-$dateNow
			cp -R -- ~/source/$i $HOME/Backup-$dateFiles
			echo "rename $i to $i-$dateNow" >> $HOME/backup-report
			fi
		else
		cp -R ~/source/$i $HOME/Backup-$dateFiles
		fi
	done

fi

