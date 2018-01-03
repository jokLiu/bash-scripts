#!/bin/bash

#check what type of input we received

#first validate that string was given
if [ "$#" -ne 1 ] ; then
    echo "Usage: $0 \"string_to_validate\""
    exit 1
fi

#check if all characters are alphanumeric
chars=$(echo "$1" | sed -e 's/[^[:alnum:]]//g')
if [ "$chars" = "$1" ] ; then
    echo "String is made of alphanumeric characters only"
fi

#check if all characters are alphabetical
chars=$(echo "$1" | sed -e 's/[^[:alpha:]]//g')
if [ "$chars" = "$1" ] ; then
    echo "String is made of alphabetical characters only"
fi

#check if all characters are upper case
chars=$(echo "$1" | sed -e 's/[^[:upper:]]//g')
if [ "$chars" = "$1" ] ; then
    echo "String is made of upper case characters only"
fi

#check if all characters are lower case
chars=$(echo "$1" | sed -e 's/[^[:lower:]]//g')
if [ "$chars" = "$1" ] ; then
    echo "String is made of lower case characters only"
fi

#check if all characters are digits
chars=$(echo "$1" | sed -e 's/[^[:digit:]]//g')
if [ "$chars" = "$1" ] ; then
    echo "String is made of digits only"
fi


