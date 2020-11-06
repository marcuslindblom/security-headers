#!/bin/sh -l

result=`securityheaders --json $1`

count=`echo $result | jq -r '[.headers[] | select(.rating == "bad")] | length'`

if [ $count -gt 0 ]
then
	printf "\n* Since last run we have detected $count bad headers:\n\n"

	for item in $(echo $result | jq -r '.headers[] | select(.rating == "bad") | @base64')
	do
		_jq() {
			echo ${item} | base64 --decode | jq -r ${1}
		}
		printf "|  Rating:               %s\t\n" "$(_jq '.rating')"
		printf "|  Description:		 %s\t\n" "$(_jq '.description')"
		printf "\n"
	done

	exit 1
else
	exit 0
fi
