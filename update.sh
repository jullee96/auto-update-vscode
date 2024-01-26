#!/bin/bash

STR1=$(curl -s https://code.visualstudio.com/updates | grep -E "v")
STR2=$(code -v | awk NR==1)


IFS='v' read -ra STRR1 <<< "$STR1"
IFS='.' read -ra STRR2 <<< "$STR2"

CURRENT_VER=$(echo "${STRR1[1]}" | sed "s/\_/\./g" )
INSTALLED_VER="${STRR2[0]}.${STRR2[1]}"
echo "CURRENT_VER : $CURRENT_VER"
echo "INSTALLED_VER : $INSTALLED_VER"
# CURRENT_VER=1.95
if [[ $CURRENT_VER > $INSTALLED_VER ]]; then
    echo "need to update" 
    curl -L -o deb/code_$CURRENT_VER.deb 'https://code.visualstudio.com/sha/download?build=insider&os=cli-alpine-x64'
    sudo dpkg -i deb/code_$CURRENT_VER.deb
else
    echo "same version" 
fi

