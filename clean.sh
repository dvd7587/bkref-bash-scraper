#!/bin/bash --

REMOVING=`ls *log *txt *csv`

echo Removing files: 
echo "$REMOVING"
echo ""
echo "Continue? Yes/[No]"
read CONTINUE

if [[ $CONTINUE == Yes || $CONTINUE == yes || $CONTINUE == Y || $CONTINUE == y ]]
then
    rm $REMOVING
    echo Removed 
    echo "$REMOVING"
else
    echo Abort removing $REMOVING
fi
