#!/bin/bash 

SURNAME=$1
NAME=$2

if [[ -z $NAME ]]
then
    CODE=$SURNAME
else
    CODE=`./player_code.sh $SURNAME $NAME`
fi

FOLDER="data"
mkdir -p $FOLDER

for LIST in players_*_urls.csv; 
do 
    grep $CODE $LIST ;     
done | 
    while read URL NAME ; 
    do 
        FILEBASE="${NAME%.*}" 
        echo $FILEBASE
        wget $URL -qO - 2>"$FILEBASE".log | \
            grep "pgl_basic" | \
            sed -e 's:data-stat="game_location" ><:>v<:g' \
                -e 's_></_> </_g' \
                -e 's_><_>X<_g' \
                -e 's/<[^>]*>/;/g' \
                -e "s_;X;_;_g" \
                -e "s_;X;_;_g" \
                -e "s_;;_;_g" \
                -e 's_ (_;_' \
                -e 's_)__' | \
            grep -v "Table" | \
            grep "[A-Z]" \
            >> "$FOLDER"/"$CODE".csv ; 
    done  


