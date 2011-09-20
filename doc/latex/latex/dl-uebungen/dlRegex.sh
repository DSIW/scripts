#!/bin/bash

HTTP="http://domain.tld"
FILEEXT="pdf"

counter="0";
while getopts 'u:r:' OPTION ; do
case "$OPTION" in
u) HTTP="$OPTARG"
((counter += 1));;
r) FILEREGEX="$OPTARG"
((counter += 1));;
*) echo "Unbekannter Parameter"
esac
done

FILEREGEX="*$FILEREGEX*.$FILEEXT"

if [ $counter -lt 2 ]; then
echo "Sie müssen 2 Parameter angeben."
exit 0
fi

wget -pr -nd -l 1 -e robots=off -A "$FILEREGEX" "$HTTP"
