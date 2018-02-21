#!/bin/bash

# Code is poetry
# Created by Nick aka black.dragon74

# Script to install the timebomb
# Must be executed from the directory of bomb.sh

# Get root access
echo "Installing the timebomb..."
echo "Please enter the administrator's password"

# If root access failed, you should exit
isRoot=$(sudo id -u 2>/dev/null)
if [[ $isRoot == "0" ]]; then
	echo "Root access gained"
else
	echo "Root elevation failed. Aborting" && exit
fi
