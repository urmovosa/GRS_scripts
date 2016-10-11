#!/bin/sh

#	This command standardizes all the files in QCd dataset to first letter upper case.
for i in *; do first=$(echo "${i:0:1}" | tr '[:lower:]' '[:upper:]'); new=$first${i:1}; mv "$i" "$new"; done

#	This command removes all dots from the files to underscores.

for fname in *; do
  name="${fname%\.*}"
  extension="${fname#$name}"
  newname="${name//./_}"
  newfname="$newname""$extension"
  if [ "$fname" != "$newfname" ]; then
    echo mv "$fname" "$newfname"
    mv "$fname" "$newfname"
  fi
done
