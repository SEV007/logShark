#!/bin/bash
: '
Simple search script Log Shark
'
eval `grep "^export " log_shark.sh`

gV=$(grep $gDt $1)

if [[ $gV == *$gDt* ]]; then
  gS=$(tail -$gDpt $1 | grep $gDt)
  if [[ "x$gS" != "x" ]]; then
	echo "$1"
	echo "$gS"
	echo ""
  fi
fi
