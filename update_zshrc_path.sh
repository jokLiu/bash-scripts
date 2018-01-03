#!/bin/bash

# validate the correct call
if [ "$#" -ne 1 ] ; then
    echo "Usage: $0 path/to/bin"
    exit 1
fi

# validate whether the directory actually exists
if [ ! -d "$1" ] ; then
    echo "File does not exist or it is not a directory"
    exit 2
fi

# add the file to the path in .zshrc
sed -i "s/export PATH=/&$1:/" ~/.zshrc > /dev/null 2>&1

# commit the update
source ~/.zshrc

# check if the path was updated
echo "$PATH" | grep "$1" > /dev/null 2>&1

if [ $? -eq 0 ] ; then
    echo "PATH was updated successfully"
else
    echo "PATH failed to update"
    exit 3
fi

