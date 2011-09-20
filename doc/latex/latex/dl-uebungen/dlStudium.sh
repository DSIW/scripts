#!/bin/bash

declare -A URI_UEB
declare -A URI_LV
declare -A PATH_UEB
declare -A PATH_LV

URI_UEB["Modul"]="http://.../Uebungen/"

URI_LV["Modul"]="http://.../Vorlesungen/"

PATH_UEB["Modul"]="/home/studium/modul/uebung"

PATH_LV["Modul"]="/home/studium/modul/vorlesung"

function dl()
{
cd $1
dlRegex.sh -u $2 -r $3
cd -
}

function dlUeb()
{
dl ${PATH_UEB[$1]} ${URI_UEB[$1]} $2
}

function dlLv()
{
dl ${PATH_LV[$1]} ${URI_LV[$1]} $2
}

function dlAll()
{
dlUeb $1 $2
dlLv $1 $3
}

# Modul:
# dlAll <modul> <regex1> <regex2>
dlAll "Modul" "uebung" "vorlesung"

