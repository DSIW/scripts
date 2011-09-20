#!/bin/bash
FILE="/tmp/paa.list"
SOURCE=$1;
DEST=$2;

# Copy package-file to /tmp/
cp $SOURCE $FILE

# Delete header (lines 1-1)
sed -i '1,1d' $FILE

# Delete whitespaces in first of line
sed -i 's/^[ \t]*//' $FILE
# Delete commands (#)
sed -e 's/#.*//' -e '/^$/ d' $FILE > "${FILE}.tmp"  
# All " " to LF
awk '{ for (i=1;i<=NF;i++) print $i }' "${FILE}.tmp" > "${FILE}.converted"
# Delete tmp-file
rm "${FILE}.tmp"
# Sort all lines and delete all multiple packages
cat "${FILE}.converted" | sort | uniq > "${FILE}.converted.sort"
# Copy back
cp -f "${FILE}.converted.sort" $DEST
