#!/bin/bash

# Code is poetry
# Created by Nick aka black.dragon74

# This project was created just for fun!

# Declare Variables
projName="Timebomb by Nick"

# Declare Functions
function showMessage(){
	messageToShow="$1"
	titleToShow=$projName
	osascript >/dev/null 2>&1 <<-EOF
		display notification "$messageToShow" with title "$titleToShow" sound name "Glass"
	EOF
}

showMessage "Detonation test!"
