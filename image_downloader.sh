#!/bin/bash

# check the input size
if [ "$#" -ne 2 ] ; then
    echo -e "\nUsage: $0 format web-page"
    echo -e "\n\tUsage Example:\n"
    echo -e "\t$0 jpeg "https://www.google.co.uk"\n "
    exit 1
fi

format="$1"
webpage="$2"
dest="/tmp/index_tmp.html"
folder="tmp"
# get the content
wget "$webpage" -O "$dest"

if [ "$?" -ne 0 ] ; then
    echo "Failed to fetch the webpage"
    echo "Please check if the webpage is correct"
    exit 1
fi

# actually fetch all the images
grep -o "http.*$format\|https.*$format" index.html | xargs -I % wget % -P $folder > /dev/null 2>&1

echo "All the possible images of the $format format were fetched to $folder"

