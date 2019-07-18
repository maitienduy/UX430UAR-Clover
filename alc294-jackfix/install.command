#!/bin/bash

###
### Jack Fix script
### Mirone, EliteMacx86, fewt
###
 
WD="`pwd`"

if [ ! $UID = 0 ]
then
  echo "Run this install script as root."
  exit 1
fi

cat <<EOF

ALC 294 Jack Fix Script
-----------------------

This script tickles the jack configuration pins to enable the
speaker out / headphone switch on startup and after wakeup.

EOF

echo "Removing previous installations."
./uninstall.command 2>/dev/null

if [ ! -d "/usr/local/bin" ]
then
  mkdir -p "/usr/local/bin"
  if [ ! $? = 0 ]
  then
    echo "Could not make directory /usr/local/bin, exiting."
    exit 1
  fi 
  chown ${USER}:admin
fi

echo "Installing JackFix"
cp ${WD}/script/jackfix.sh /usr/local/bin
chmod 755 /usr/local/bin/jackfix.sh
chown root:wheel /usr/local/bin/jackfix.sh

echo "Installing hda-verb"
cp ${WD}/bin/hda-verb /usr/local/bin
chmod 755 /usr/local/bin/hda-verb
chown root:wheel /usr/local/bin/hda-verb

echo "Installing sleepwatcher"
cp ${WD}/bin/sleepwatcher /usr/local/bin
chmod 755 /usr/local/bin/sleepwatcher
chown root:wheel /usr/local/bin/sleepwatcher

echo "Install and start jackfix launcher"
cp ${WD}/launchers/jackfix.plist /Library/LaunchAgents/
chmod 644 /Library/LaunchAgents/jackfix.plist
chown root:wheel /Library/LaunchAgents/jackfix.plist
launchctl load /Library/LaunchAgents/jackfix.plist

echo "Install and start sleepwatcher launcher"
cp ${WD}/launchers/sleepwatcher.plist /Library/LaunchAgents/
chmod 644 /Library/LaunchAgents/sleepwatcher.plist
chown root:wheel /Library/LaunchAgents/sleepwatcher.plist
launchctl load /Library/LaunchAgents/sleepwatcher.plist
