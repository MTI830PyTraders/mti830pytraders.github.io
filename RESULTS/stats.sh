#!/bin/bash

shopt -s extglob

for i in $(ls -G +(pe|de|pb|fcf|peg)*_+(MCD|DIS|INTC|AAPL|MSFT|WDC)* | grep ':' | sed  's/://' - ); do echo $i; (head -n1 $i/keras.log.csv ; tail -n10 $i/keras.log.csv ) | awk -F';' ' {  sum3 += $3; sum4 += $4 ; sum6 += $6 ; sum7 += $7} NR==1  {print $3 " " $4 " " $6 " " $7 } END {print  sum3/10 " "  sum4/10  " "  sum6/10 " " sum7/10 }' |  column -t ; echo "" ; done
