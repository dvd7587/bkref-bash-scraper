#! /bin/bash -x

touch allnames.csv ;
touch uniquenames.csv ; 

for CSVFILE in `ls players*csv`
do
    cut $CSVFILE -d " " -f 2 | cut -d "_" -f 1 >> allnames.csv
done

while read PLAYER
do
    COUNT=`grep $PLAYER uniquenames.csv | wc -l`
    if [[ $COUNT == 0 ]]
    then
        echo $PLAYER >> uniquenames.csv
    fi
done < allnames.csv

