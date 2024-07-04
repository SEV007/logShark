#!/bin/bash
: '
Simple search script Log Shark
'
eval `grep "^export " log_shark.sh`

gV=$(grep $gStr $1)

if [[ $gV == *$gDt* ]] && [[ $gV == *$gStr* ]]; then
  gS=$(tail -$gDpt $1 | grep $gStr | grep $gDt)
  if [[ "x$gS" != "x" ]]; then
	echo "$1"
	echo "$gS"
	echo ""
  fi
fi
