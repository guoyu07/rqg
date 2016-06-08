#!/bin/bash
#
#$1 = Test database name
#$2 = number of concurrent sessions
#
   testDB=$1
   scriptFile=$2
   numSess=$3
#  
   if [ $# != 3 ]; then
      echo  Usage: queryLineitem.sh testDB scriptFile numSessions
      echo "   ex: queryLineitem.sh mytest myScript.sql 30"
      exit
   fi
#
   source $MYRHOME/common/env/myrclient.sh
   fileName=`basename $scriptFile`
   for (( sess=1; sess<=$numSess; sess++ ))
   do
      $MYRCLIENT $testDB -vvv -f <$scriptFile > $fileName$sess.log 2>&1 &
      pids[$sess]=$!
   done
#
   stillGoing=1
   while [ $stillGoing -gt 0 ]
   do
      stillGoing=0
      for (( sess=1; sess<=numSess; sess++ ))
      do
         if [ ${pids[sess]} -ne 0 ]
         then
            lines=`ps -p ${pids[sess]} |wc -l`
            if [ $lines -eq 1 ]
            then
               pids[$sess]=0
            else
               stillGoing=1
               break
            fi
         fi
      done
      if [ $stillGoing -eq 1 ]
      then
         sleep 1
      fi
   done

