#!/bin/bash 

function usage()
{
    echo "Download the full NBA player boxscores links for the specified season."
    echo ""
    echo "./season_schedule.sh [OPTIONS] [YEAR]"
    echo "OPTIONS:"
    echo "-h --help  : Print this message and quit" 
    echo ""
    echo "Files players_YEAR.log is updated, while players_YEAR.txt and "
    echo "players_YEAR_urls.csv are overwritten (backed up in the log file) "
    echo "in the current directory. Default YEAR is `date +%Y`"
    echo ""
    echo "Example: "
    echo "./season_players.sh 2010"
}

YEAR=$1

if [[ $YEAR == -h || $YEAR == --help ]] ;
then
    usage 
    exit 0 
else 
    if [[ -z $YEAR ]]
    then
        YEAR=`date +%Y`
    fi
fi
    
BKREFURL="https://www.basketball-reference.com/"

LOGFILE=players_"$YEAR".log
TXTFILE=players_"$YEAR".txt
CSVFILE=players_"$YEAR"_urls.csv

echo "------------------------------------------------- BACKUP "$TXTFILE" -------------------------------------------------" >> $LOGFILE;
touch $TXTFILE ;
cat $TXTFILE >> $LOGFILE;
rm $TXTFILE ;

echo "---------------------------------------------- BACKUP "$CSVFILE" -----------------------------------------------" >> $LOGFILE;
touch $CSVFILE ; 
cat $CSVFILE >> $LOGFILE;
rm $CSVFILE ;

echo "-------------------------------------------------- UPDATING players_"$YEAR" --------------------------------------------------"  >> $LOGFILE;

echo "Getting "$YEAR" ..."
PAGEPATH="leagues/NBA_"$YEAR"_per_game.html" ; 
wget "$BKREFURL""$PAGEPATH" -O - 2>> $LOGFILE | grep 'data-stat="player"' >> $TXTFILE
grep "full_table" $TXTFILE | cut -d "<" -f 6 | cut -d '"' -f 2 > $CSVFILE
paste -d " " $CSVFILE $CSVFILE > $CSVFILE.tmp ;
sed -i -e "s_/players_"$BKREFURL"players_" \
       -e "s_.html_/gamelog/"$YEAR"_"      \
       -e "s_ /players/./_ _"              \
       -e "s:.html:_"$YEAR".html:"         \
       $CSVFILE.tmp
mv $CSVFILE.tmp $CSVFILE

echo "------------------------------------------------ DONE UPDATING players_"$YEAR" -----------------------------------------------"  >> $LOGFILE;


