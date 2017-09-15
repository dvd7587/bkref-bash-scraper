#!/bin/bash 

YEAR=$1

touch schedule_"$YEAR".txt ; 
echo "------------------------------------------------- BACKUP schedule_"$YEAR".txt -------------------------------------------------" >> schedule_"$YEAR".log;
cat schedule_"$YEAR".txt >> schedule_"$YEAR".log;

touch schedule_"$YEAR"_urls.csv ; 
echo "---------------------------------------------- BACKUP schedule_"$YEAR"_urls.csv -----------------------------------------------" >> schedule_"$YEAR".log;
cat schedule_"$YEAR"_urls.csv >> schedule_"$YEAR".log;

echo "-------------------------------------------------- UPDATING schedule_"$YEAR" --------------------------------------------------" >> schedule_"$YEAR".log;

for MONTH in october november december january february march april may june ;
do
    echo "Getting "$YEAR"/"$MONTH" ..."
    wget https://www.basketball-reference.com/leagues/NBA_"$YEAR"_games-"$MONTH".html -O - 2&>> schedule_"$YEAR".txt.log | grep 'data-stat="box_score_text"' >> schedule_"$YEAR".txt
    grep -v aria schedule_$YEAR.txt | cut -d "<" -f "22-30" | cut -d '"' -f 2 > schedule_"$YEAR"_urls.csv
done

echo "------------------------------------------------ DONE UPDATING schedule_"$YEAR" -----------------------------------------------" >> schedule_"$YEAR".log;
