#/bin/bash -x

SURNAME=$1
NAME=$2

echo "${SURNAME,,}" | cut -c "1-5" | read CODEONE
echo "${NAME,,}"    | cut -c "1-2" | read CODETWO

CODE="$CODEONE""$CODETWO"




#for i in players_*_urls.csv; do grep bledser $i ; grep turnemy $i ; grep butleji $i; done | while read URL NAME ; do echo wget $URL -O mydir/$NAME ; done  

#while read URL NAME
#for i in `ls` ; do filebase="${i%.*}" ; echo $i "->" $filebase ; grep pgl_basic $i > $filebase.1 ; done
#sed -e 's:data-stat="game_location" ><:>v<:g' -e 's_><_> <_g' -e 's/<[^>]*>/;/g' -e "s_; ;_;_g" -e "s_; ;_;_g" -e 's_ (_;_' -e 's_)__' bledser01_2011.1 

