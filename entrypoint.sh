#!/bin/bash

if [[ $# == 0 ]]; then
    echo "Usage: url [grade] [followRedirects]"
    echo "* url: URL to analyse."
    echo "* grade: The desired security grade of your HTTP response headers. Possible grades: A+, A, B, C, D, E, F. Defaults to B."
    echo "* followRedirects: Follow redirects. Defaults to on, set to off or false to disable."
    exit 1
fi

GRADE=${2:-'B'}
FOLLOW_REDIRECTS=${3-'1'}
FOLLOW_REDIRECTS=${FOLLOW_REDIRECTS/true/1}
FOLLOW_REDIRECTS=${FOLLOW_REDIRECTS/on/1}
FOLLOW_REDIRECTS=${FOLLOW_REDIRECTS/false/0}
FOLLOW_REDIRECTS=${FOLLOW_REDIRECTS/off/0}

declare -A grades=(
    ['A+']=7
    ['A']=6
    ['B']=5
    ['C']=4
    ['D']=3
    ['E']=2
    ['F']=1
)

RATING=$(curl -s -L "https://securityheaders.com/?hide=on&followRedirects=$FOLLOW_REDIRECTS&q=$1" -I | sed -En 's/x-grade: (.*)/\1/p' | tr -d '\r')

echo "::set-output name=rating::$RATING"

if [[ $RATING = "R" ]]; then
    echo "$1 returned a redirect, enable the followRedirects option to scan this URL."
    exit 1
fi

if [[ ${grades[$RATING]} -ge ${grades[$GRADE]} ]]; then
    exit 0
else
    exit 1
fi
