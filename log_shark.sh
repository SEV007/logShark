#!/bin/bash
: '
Simple search script Log Shark
'

loc=$(pwd)

function menu {
	echo ""
	echo "################## MENU ##################"
	N=${#options[@]}
	c=0
	echo "Current Location: $loc"
	for((i=0;i<N;i++)); do
	c=$(($c + 1))
	echo "$c) ${options[$i]}"
	done
	echo "##########################################"
}

echo "################## MENU ##################"
echo "Current Location: $loc"
PS3='Select option from [0-4]: '
options=("Search by Date and String" "Search by Date Only" "Search by String Only" "Find File" "Exit")
select opt in "${options[@]}"
do
	case $opt in
		"Search by Date and String")
			if [[ -v gStr ]]; then
			  echo
			else
			  echo "##########################################"
			  printf '%s\n'
			  read -p "Search string: " gStr
			  echo "Day and Month are optional (Example 2023/09/21 or 2023/09 or 2023)"
			  read -p "Date: yy/mm/dd " gDt
			  read -p "Search Depth (Last X lines of file): " gDpt
			  export gStr
			  export gDt
			  export gDpt
			fi

			find ./ -type f -name \* -exec ./grep.cmd {} \;
			menu
			unset gStr
			unset gDt
			unset gDpt
			;;
		"Search by Date Only")
			if [[ -v gStr ]]; then
			  echo
			else
			  echo "##########################################"
			  printf '%s\n'
			  echo "Day and Month are optional (Example 2023/09/21 or 2023/09 or 2023)"
			  read -p "Date: yy/mm/dd " gDt
			  read -p "Search Depth (Last X lines of file): " gDpt
			  export gDt
			  export gDpt
			fi

			find ./ -type f -name \* -exec ./grep_date_only.cmd {} \;
			menu
			unset gStr
			unset gDt
			unset gDpt
			;;
		"Search by String Only")
			if [[ -v gStr ]]; then
			  echo
			else
			  echo "##########################################"
			  printf '%s\n'
			  read -p "Search string: " gStr
			  read -p "Search Depth (Last X lines of file): " gDpt
			  export gStr
			  export gDpt
			fi

			find ./ -type f -name \* -exec ./grep_string_only.cmd {} \;
			menu
			unset gStr
			unset gDt
			unset gDpt
			;;
		"Find File")
			if [[ -v gStr ]]; then
			  echo
			else
			  echo "##########################################"
			  printf '%s\n'
			  read -p "Search file: " gStr
			  export gStr
			fi

			find ./ -type f | grep $gStr
			menu
			unset gStr
			;;
		"Exit")
			break
			;;
		*)
		menu
		echo "invalid option $REPLAY"
		;;
	esac
done
