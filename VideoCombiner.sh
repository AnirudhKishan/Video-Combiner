#!/bin/bash

FILES=Videos/*.AVI # Modify as appropriate

for f in $FILES
do
  if grep -Fxq "$f" processed.txt
  then
    continue
  else
    echo "Processing file: $f"
  
    fileExtension="${f##*.}"
    
    v1="${f%%.*}"
    fileName="${v1##*/}"
    
    fileLocation="${v1%/*}"
    
    ffmpeg -threads 1 -i "$f" -threads 1 "${fileLocation}/${fileName}.mkv"
  
    mkdir -p "${fileLocation}/processed"
  
    mv "${fileLocation}/${fileName}.${fileExtension}" "${fileLocation}/processed/${fileName}.${fileExtension}"
    
    echo $f >> processed.txt
  fi

done
