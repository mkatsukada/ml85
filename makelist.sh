#!/bin/bash

ML84=namelist.txt
ML84_MOD=modukelist.txt
ML85=RHEL85_fin.txt
UPDATE=dnfupdate.sh
LINE=($(wc -l $ML84 | sed -e 's/\s.*//g'))
LINE_MOD=($(wc -l $ML84_MOD | sed -e 's/\s.*//g'))

for ((i=1; i<"$LINE"+1; i++))
 do
         NAME=($(sed -n "$i"p "$ML84"))
         VIR=($(grep ^"$NAME"-[0-9] "$ML85"))
         echo $VIR >> "$UPDATE"
 done

for ((x=1; x<"$LINE_MOD"+1; x++))
 do
	 NAME=($(sed -n "$i"p "$ML84_MOD"))
	 VIR=($(grep ^"$NAME" "$ML85"))
 	 echo $VIR >> "$UPDATE"
 done

sed -i '/^$/d' $UPDATE
sed -i 's/$/ \\/g' $UPDATE
sed -i 's/\.module+el8.*/\* \\/g' $UPDATE
sed -i '1s/^/\#!\/bin\/bash\n/' $UPDATE
sed -i '2s/^/dnf update /' $UPDATE
chmod 755 $UPDATE
