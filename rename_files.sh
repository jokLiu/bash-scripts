#!/bin/bash

before=" "
after="_"
dir="*"
# check usage
if [ "$#" -eq 3 ] ; then
    before="$1"
    after="$2"
    dir="$3\/$dir"
else
    echo -e "Default tokens will be used"
    echo -e "All the files with \"$before\" will be replaced with \"$after\""
    echo -e "\nNon default usage is $0 token_to_be_replaced new_token directory\n"
    echo -e "Example: $0 \" \" \"-\" \".\""
fi

# actual call
rename "y/$before/$after/" $dir

if [ "$?" -ne 0 ] ; then
    echo "rename failed"
    exit 1
fi

# otherwise rename was successful
echo "rename succeeded"
