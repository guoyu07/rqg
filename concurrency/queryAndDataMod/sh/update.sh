#!/bin/bash
#
   testDB=$1
#
#  multiplier is used to divide the table into 10 row ranges
#  For tpch10.lineitem, it is 6000000
#  For tpch100.lineitem, it is 60000000
   multiplier=6000000
#
   keepGoing=1
   addValue=1
   rangeIdx=1
   while [ $keepGoing -eq 1 ]; do
      echo "update lineitem set l_suppkey = l_orderkey + $addValue where l_orderkey >= $((($rangeIdx-1)*$multiplier+1)) and l_orderkey <= $(($rangeIdx*$multiplier));" > update.sql
      $MYRCLIENT $testDB -vvv <update.sql >> update.log 2>&1
#
      ((rangeIdx++))
      if [ $rangeIdx -ge 11 ]; then
         rangeIdx=1
         ((addValue++))
      fi
#
      if [ -f continue.txt ]; then
         keepGoing=`cat continue.txt`
      fi
   done
