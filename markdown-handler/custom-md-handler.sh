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

md_to_html "$mdfile" > "$htmlFile"
improve_html "$htmlFile" > "$improvedHtmlFile"
chmod +r "$improvedHtmlFile"
# copying it to current directory, because firefox cannot read form /tmp even after chmod +r
cp "$improvedHtmlFile" . || echo "Failed copying file"
firefox "$(basename "$improvedHtmlFile")" 2> /dev/null
sleep 2 # sleep so that firefox can still see the file
rm "$(basename "$improvedHtmlFile")"
