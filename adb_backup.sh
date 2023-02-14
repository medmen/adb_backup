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
	for APP in $(adb shell pm list packages -3)
	do
	  APP=$( echo ${APP} | sed "s/^package://")
	  adb backup -f ${APP}.backup ${APP}
	done

	return 1
}

restore () {
	adb restore application.backup

	return 1
}

dumplist () {
	let "i=0"
	for APP in $(adb shell pm list packages -3)
	do
	  APP=$( echo ${APP} | sed "s/^package://")
	  echo ${APP} >> pkglist.txt
	  let "i++"
	done
	echo "wrote $i packages to pkglist.txt"

	return 1
}

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

*)
echo "dieses Kommando kenne ich nicht - unknown command"
exit 1

esac



