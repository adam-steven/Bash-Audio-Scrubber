#!/bin/bash

#Set input file path
PATHIN=$(pwd)
#If user inputs an argument use that as the input path
if [ $# -eq 1 ]
then
	PATHIN="$1"
fi

#Set output file path
PATHOUT="no_audio_vids"
mkdir -p "$PATHOUT/$PATHIN"

#Count the number of files that will be affected
COUNTER=0
#Prevent loop from running if there are no matching files
shopt -s nullglob
for CFILE in "$PATHIN"/*.mp4
do
	#The program cannot run on files with spaces
	#Outputing all the gathered file show all invalid file names
	file $CFILE
	((COUNTER=COUNTER+1))
done

#Double check before continuing
echo #new line
echo "The input file are from $PATHIN"
echo "The files will be outputted to $PATHOUT"
echo "$COUNTER file(s) that will be effected"
echo #new line
read -p "Do you want to continue ? [Y/n] " -n 1 -r
echo #new line

#Standared linux agreement input
if [[ $REPLY =~ ^[Yy]$ ]]
then
	shopt -s nullglob
	for CFILE in "$PATHIN"/*.mp4
	do
		#ffmpeg file copy with no audio
		FILEOUT="$PATHOUT/$CFILE"
		ffmpeg -i "$CFILE" -c copy -an "$FILEOUT"
	done
fi

