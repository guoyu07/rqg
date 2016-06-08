#!/bin/bash
#
   testType=$1
#
   rm -f status.$testType.tmp
   case "$testType" in
      cpimport|ldi|partition)
         cnt=`grep -i Result query.$testType.sql.log.*|grep -v select|grep Bad|wc -l`
         if [ $cnt = 0 ]; then
            status=Passed
         else
            status=Failed
         fi
         echo $status >status.$testType.tmp
         ;;
#
      update|delete|ddl)
         cntDiff=""
         rangeDiff=""
         err=0
#
         rm -f status.tmp
         cat query.$testType.sql.log.* |grep Result|grep -v select>/tmp/result.txt
         cat /tmp/result.txt |
         while read bar1 flag bar2 minValue bar3 maxValue bar4 actCnt restOfLine; do
             expCnt=`cat $MYRHOME/concurrency/queryAndDataMod/data/resultCnts.txt|grep $flag|awk -F" " '{print $2}'`
             cntDiff=$(($expCnt-$actCnt))
             rangeDiff=$(($maxValue-$minValue))
#             if ([ $cntDiff -eq 0 ] || [ $cntDiff -eq $expCnt ]) && ([ $rangeDiff -eq 5999999 ] || [ $rangeDiff -eq 99999 ]); then
             if ([ $cntDiff -eq 0 ] || [ $cntDiff -eq $expCnt ]); then
                echo Passed >>status.$testType.tmp
             else
                echo Failed cntDiff=$cntDiff rangeDiff=$rangeDiff maxValue=max$maxValue min-Value=$minValue $rangeDiff >>status.$testType.tmp
             fi
         done
         ;;
#
      droppart)
         ;;
   esac
#
   cnt=`cat status.$testType.tmp|grep Failed|wc -l`
   if [ $cnt -eq 0 ]; then
      echo $testType Passed >> testStatus.txt
   else
      echo $testType Failed >> testStatus.txt
   fi
   