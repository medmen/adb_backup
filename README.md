# adb_backup

adb_backup is a bash script to backup android phones using the adb system. 
Right now the focus is to back up apps and their settings. Maybe other things may follow

## target

this file is a bash script. It "should" run in any bash environment. Tested and developed under Ubuntu Linux, i cannot prove it to work anywhere else 

## installation

simply checkout or download the adb_backup.sh script and make it executable via

```bash
sudo chmod +x abd_backup.sh
```

## usage

connect your phone via adb and make sure usb_debugging is enbabled (developer options)

run the script it from terminal using 
```bash
./abd_backup.sh
```

the script will walk you through the process, but here are the options
in detail:

### (d)ump

this populates a text file holding all apps in your phone. 
You may edit this file to create custom backups. 
CAUTION! calling this option again will overwrite the file without asking!

### (b)ackup

this will backup each app in the dumped list as 
appname.apk and (if the app permits) will also backup settings as appname.backups
Backup target is a subfolder named after your phone. 
CAUTION! if you own 2 phones of the exact same type, you may mess up here!

### (r)estore

this will restore the backups.
I will add a few options soon. 

### (q)uit

leave the script (duh) 
