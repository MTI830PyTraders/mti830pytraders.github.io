#!/bin/bash
shopt -s extglob
declare -a FEATURES=("pe" "de" "pb" "fcf" "peg")

for FEATURE in "${FEATURES[@]}"; do
    echo "Feature: $FEATURE"
    for i in $(ls -G +(pe|de|pb|fcf|peg)*_+(MCD|DIS|INTC|AAPL|MSFT|WDC)* | grep ':' | sed  's/://' - ); do echo $i; (head -n1 $i/keras.log.csv ; tail -n10 $i/keras.log.csv ) | awk -F';' ' {  sum3 += $3; sum4 += $4 ; sum6 += $6 ; sum7 += $7} NR==1  {print $3 " " $4 " " $6 " " $7 } END {print  sum3/10 " "  sum4/10  " "  sum6/10 " " sum7/10 }'  ; echo "" ; done  | grep $FEATURE -A3 | grep -v $FEATURE | awk -F ' ' '{ sum1 += $1; sum2 += $2 ; sum3 += $3 ; sum4 += $4  } END {print "MAPE MAE MAPE_val MAE_val"   } END {print sum1/7 " " sum2/7 " " sum3/7 " " sum4/7 } ' | column -t
    echo ""
done
