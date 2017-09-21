#!/bin/bash -x

SURNAME=$1
NAME=$2

CODE=`./player_code.sh $SURNAME $NAME`

mkdir $CODE

for LIST in players_*_urls.csv; 
do 
    grep $CODE $LIST ;     
done | 
    while read URL NAME ; 
    do 
        FILEBASE="${NAME%.*}" 
        wget $URL -qO - 2>"$FILEBASE".log | grep "pgl_basic" | \
            sed -e 's:data-stat="game_location" ><:>v<:g' \
                -e 's_><_> <_g' \
                -e 's/<[^>]*>/;/g' \
                -e "s_; ;_;_g" \
                -e "s_; ;_;_g" \
                -e 's_ (_;_' \
                -e 's_)__' \
                > "$CODE"/"$FILEBASE".csv ; 
    done  


