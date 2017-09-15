#!/bin/bash 

function usage()
{
    echo "Download the full NBA schedule links for the specified season."
    echo ""
    echo "./season_schedule.sh [OPTIONS] YEAR"
    echo "OPTIONS:"
    echo "-h --help  : Print this message and quit" 
    echo ""
    echo "Files schedule_YEAR.log is updated, while schedule_YEAR.txt and "
    echo "schedule_YEAR_urls.csv are overwritten (backed up in the log file) "
    echo "in the current directory."
    echo ""
    echo "Example: "
    echo "./season_schedule.sh 2008"
}

YEAR=$1

if [[ $YEAR == -h || $YEAR == --help ]] ;
then
    usage 
    exit 0 
fi
    
BKREFURL="https://www.basketball-reference.com/"

LOGFILE=schedule_"$YEAR".log
TXTFILE=schedule_"$YEAR".txt
CSVFILE=schedule_"$YEAR"_urls.csv

touch $TXTFILE ;
echo "------------------------------------------------- BACKUP "$TXTFILE" -------------------------------------------------" >> $LOGFILE;
cat $TXTFILE >> $LOGFILE;

touch $CSVFILE ; 
echo "---------------------------------------------- BACKUP "$CSVFILE" -----------------------------------------------" >> $LOGFILE;
cat $CSVFILE >> $LOGFILE;

echo "-------------------------------------------------- UPDATING schedule_"$YEAR" --------------------------------------------------"  >> $LOGFILE;

for MONTH in october november december january february march april may june ;
do
    echo "Getting "$YEAR"/"$MONTH" ..."
    wget "$BKREFURL"leagues/NBA_"$YEAR"_games-"$MONTH".html -O - 2&>> $LOGFILE | grep 'data-stat="box_score_text"' >> $TXTFILE
    grep -v aria schedule_$YEAR.txt | cut -d "<" -f "22-30" | cut -d '"' -f 2 > $CSVFILE
    sed -i -e "s_/boxscores_"$BKREF_URL"boxscores_" $CSVFILE
done

echo "------------------------------------------------ DONE UPDATING schedule_"$YEAR" -----------------------------------------------"  >> $LOGFILE;

read NUMGAMES <<< $(wc -l $CSVFILE )
if test $NUMGAMES -lt 1 ;
then
    exit 1
fi
exit 0

