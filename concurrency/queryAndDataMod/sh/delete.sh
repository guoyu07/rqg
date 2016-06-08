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
   rangeIdx=1
   while [ $keepGoing -eq 1 ]; do
#      echo "set autocommit=0;" > delete.sql
      echo "delete from lineitem where l_orderkey >= $((($rangeIdx-1)*$multiplier+1)) and l_orderkey <= $(($rangeIdx*$multiplier));" >> delete.sql
#      echo "rollback;" >> delete.sql
      $MYRCLIENT $testDB -f -vvv <delete.sql >> delete.log 2>&1
#
      ((rangeIdx++))
      if [ $rangeIdx -ge 11 ]; then
         rangeIdx=1
      fi
#
      if [ -f continue.txt ]; then
         keepGoing=`cat continue.txt`
      fi
   done
