#!/usr/bin/env bash

#/**
#
# 1) If you don't know the package-name, you can create a list of all installed packages (sorted in alphabetical prder without app names)
#
# adb shell pm list packages -f | sed -e 's/.*=//' | sort
#
# 2) Now look for the desired app you want to extract/backup the apk from. Then run following command:
#
# adb shell pm path com.example.someapp
#
# You will get an output which will look something like the following:
# package:/data/app/com.example.someapp-1/base.apk
#
# 3) With this information you can simply perform a pull-command like the following:
# adb pull -a -p /data/app/com.example.someapp-1/base.apk C\LOCAL\PATH\TO\YOUR\BACKUP\com.example.someapp-1/base.apk
#
#*/

backup () {
	# reading data from a file
	COUNT=1
	FILE=${DEVICE}.txt
	# check if target dir exists, create if not
	if [ ! -d ./${DEVICE} ]; then
		mkdir ./${DEVICE};
	fi
	
	cat ${FILE} | while read LINE
	do
		echo "Line $COUNT: $LINE"
		APP=$( echo ${LINE} | sed "s/^package://")
		# echo "TEST write ${DEVICE}/${APP}.backup"
		adb backup -f ./${DEVICE}/${APP}.backup ${APP}
		let "COUNT++"
	done
	echo "Finished processing the file"
	return 1
}

restore () {
	adb restore application.backup

	return 1
}

dumplist () {
	FILE=${DEVICE}.txt
	# if a proper file exists, dont overwrite
	if [[ -f "$FILE" ]]; then
		echo "A dumplist for your Phone model exists already. To create a new one, delete or rename $FILE"
		exit 1
	fi
	

	let "i=0"
	for APP in $(adb shell pm list packages -3)
	do
	  APP=$( echo ${APP} | sed "s/^package://")
	  echo ${APP} >> ${FILE}
	  let "i++"
	done
	echo "wrote $i packages to $FILE"

	return 1
}

main () {
	# read connected phone
	DEVICE=$(adb devices -l | sed "s/.*model\://" | awk 'FNR==2{print $1}')
	if [[ -z "$DEVICE" ]]; then
		echo "No Device attached"
		exit 1
	fi

	read -p "(d)ump, (b)ackup,(r)estore: " COMMAND

	case $COMMAND in
		d)
		dumplist
		;;
		dump)
		dumplist
		;;

		b)
		backup
		;;
		backup)
		backup
		;;

		r)
		restore
		;;
		restore)
		restore
		;;

		q)
		echo "see you soon"
		exit 1
		;;
		quit)
		quit
		echo "see you soon"
		exit 1
		;;

		*)
		echo "dieses Kommando kenne ich nicht - unknown command"
		exit 1
	esac
}

main
