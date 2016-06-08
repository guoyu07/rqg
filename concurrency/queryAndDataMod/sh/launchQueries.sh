#!/bin/bash
#
   testDB=$1
   scriptFile=$2
   numSess=$3
   secsToSleep=5
#
   keepGoing=1
   while [ $keepGoing -eq 1 ]; do
      $MYRHOME/common/sh/execSQLScriptConcur.sh $testDB $MYRHOME/concurrency/queryAndDataMod/sql/$scriptFile $numSess
      for ((sess=1;$sess<=numSess;sess++)); do
         cat $scriptFile$sess.log >> $scriptFile.log.$sess
         rm -f $scriptFile$sess.log
      done
      if [ -f continue.txt ]; then
          keepGoing=`cat continue.txt`
      fi
      sleep $secsToSleep
   done
