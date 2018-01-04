#!/bin/bash

function retrieve_email() {
# check the usage
if [ "$#" -ne 2 ] ; then
    echo -e "\tUsage: $0 web-page file_to_put_emails"
    echo -e "\n\tExample Usage"
    echo -e "\tUsage: $0 http://example.com email.txt"
    exit 1
fi

# get the the html file
webpage="$1"
dest="/tmp/index_tmp.html"
folder="tmp"
email_dest="$2"
# get the content
wget "$webpage" -O "$dest"

if [ "$?" -ne 0 ] ; then
    echo "Failed to fetch the webpage"
    echo "Please check if the webpage is correct"
    return 1
fi

# actually retrieve the emails
grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" "$dest" >> "$email_dest"

# cleanup
rm -rf "$dest"

}

# check the input 
if [ "$#" -ne 2 ] ; then
    echo -e "\tUsage: $0 file_with_web-page file_to_put_emails"
    echo -e "\n\tExample Usage"
    echo -e "\tUsage: $0 pages.txt email.txt"
    exit 1
fi

pages="$1"
out="$2"

# main function
while read -r line
do
    retrieve_email "$line" "$out" 
done < "$pages"

echo "All the possible email were retrieved"
