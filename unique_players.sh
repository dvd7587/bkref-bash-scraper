#! /bin/bash -x

touch all_codes.csv ;
touch unique_codes.csv ; 

for CSVFILE in `ls players_*_urls.csv`
do
    cut $CSVFILE -d " " -f 2 | cut -d "_" -f 1 >> all_codes.csv
done

while read PLAYER
do
    COUNT=`grep $PLAYER unique_codes.csv | wc -l`
    if [[ $COUNT == 0 ]]
    then
        echo $PLAYER >> unique_codes.csv
    fi
done < all_codes.csv

