#!/bin/bash
FILE="/tmp/packages.list"
SOURCE=$1
DEST=$2

# Copy package-file to /tmp/
cp $SOURCE $FILE

# Delete header (lines 1-4)
sed -i '1,4d' $FILE

# Delete non-packages
sed -i 's/aptitude//g' $FILE
sed -i 's/apt-get//g' $FILE
sed -i 's/install//g' $FILE
sed -i 's/-y//g' $FILE
sed -i 's/sudo//g' $FILE

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

# Count all multiple packages
echo "deleted packages:"
bc <<< `wc -l "${FILE}.converted" | cut -d ' ' -f1`-`wc -l "${FILE}.converted.sort" | cut -d ' ' -f1`

