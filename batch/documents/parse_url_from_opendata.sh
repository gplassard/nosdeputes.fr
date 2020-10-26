#!/bin/bash

url=$1
output=$2

docid=$(echo $url | sed 's|.*/||' | sed 's/.asp//' | awk -F '-' '{print $1}' | sed 's/[^0-9]//g')

find opendata/document/ -name '*'$docid'*' | while read file ; do
    python3 parse_opendata_documents.py $file > "/tmp/documents_$$.json"
    if grep "$url" "/tmp/documents_$$.json"  > "$output" ; then
        break;
    fi
done
rm /tmp/documents_$$.json

if ! test -s "$output"; then
    echo "$0: $url not found" 1>&2 ;
    rm -f "$output"
elif ! jq . < "$output" | grep '"contenu": "[^"]' > /dev/null; then
    echo "$0: erreur de contenu avec $url" 1>&2 ;
fi
