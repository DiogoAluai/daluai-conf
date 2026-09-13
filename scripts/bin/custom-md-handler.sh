#!/usr/bin/env bash

##
## Handler for md files, meant for xdg-open
##

if [ $# != 1 ]; then
    echo "Usage: command <file.md>."
    exit 1
fi

mdfile=$1

htmlFile=$(mktemp)
improvedHtmlFile=$(mktemp --suffix=.html)

md_to_html $mdfile > $htmlFile
improve_html $htmlFile > $improvedHtmlFile
chmod +r $improvedHtmlFile
cp $improvedHtmlFile .
firefox $(basename $improvedHtmlFile) 2> /dev/null
rm $(basename $improvedHtmlFile)
