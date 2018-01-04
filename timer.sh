#!/bin/bash

# check if it was called correctly
if [ "$#" -ne 1 ] ; then
    echo "Usage: $0 \"00:00:00\" "
    exit 1
fi

# validate the format
check="$( echo "$1" | egrep "[[:digit:]]{0,2}:?[[:digit:]]{0,2}:?[[:digit:]]{1,2}" )"
if [ "$?" -ne 0 ] ; then
    echo "Input string is not of the valid format"
    echo "Valid formats include: "
    echo "\t hh:mm:ss "
    echo "\t    mm:ss "
    echo "\t       ss "
    exit 2
fi

hours=$( echo "$1" | cut -d: -f1 )
minutes=$( echo "$1" | cut -d: -f2 )
seconds=$( echo "$1" | cut -d: -f3 )

fields=$( echo "$1" | grep -o ":" | wc -l )

if [ "$fields" -eq 0 ] ; then
    minutes=""
    hours=""
elif [ "$fields" -eq 1 ] ; then
    seconds=$minutes
    minutes=$hours
    hours=""
fi
# validate size
# minutes should be [0; 59]

if [ ! -z "$minutes" ] ; then
    if [ "$minutes" -gt 59 ] ; then
        echo "Minutes should not exceed 59"
        exit 1
    fi
fi

# seconds should be [0; 59]
if [ ! -z "$seconds" ] ; then
    if [ "$seconds" -gt 59 ] ; then
        echo "Seconds should not exceed 59"
        exit 1
    fi
fi

total=$seconds
#actual counter
#translate time into seconds
if [ ! -z "$minutes" ]  ; then
    total=$(( $minutes * 60 + $total ))
else
    minutes="00"
fi
if [ ! -z "$hours" ] ; then
    total=$(( $hours * 3600 + $total ))
else
    hours="00"
fi

echo $hours $minutes $seconds
#get the time in seconds
time=$( date +%s )
while [ $total -gt 0 ] ; do
    curr=$( date +%s )
    if [ "$time" -ne "$curr" ] ; then
        time=$curr
        echo -ne  "$hours:$minutes:$seconds"\\r
        (( total-=1 ))
        (( hours=total/3600  ))
        (( minutes=total/60 ))
        (( seconds=total%60 ))
    fi
done

