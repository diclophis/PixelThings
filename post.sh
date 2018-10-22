#!/bin/sh

echo $1 $2 1>&2

PARSE_APPLICATION_ID=519e32bde6ce6398dedd6217ed3aea09b086ab6d
PARSE_MASTER_KEY=20149bac5229a250b10b5a8cbdabb2082c7aae54

curl -s -# -H "X-Parse-Application-Id: $PARSE_APPLICATION_ID" -H "X-Parse-REST-API-Key: $PARSE_MASTER_KEY" -X POST -H "Content-Type: application/json" -d "$1" "$2" | sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep objectId | cut -d: -f 2
