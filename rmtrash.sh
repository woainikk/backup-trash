#!/bin/bash
fileName=$1
count="$(cat count)"

[ $# -eq 0 ] && exit
[ -d "$1" ] && exit

[ -e ~/.trash ] || mkdir ~/.trash

[ -e $PWD/"$fileName" ] || exit 

ln -- "$fileName" ~/.trash/$count
path="$PWD/"$fileName""

echo "$path:$count" >> ~/.trash.log
let count=$count+1
echo "$count">count

rm -- "$fileName"


