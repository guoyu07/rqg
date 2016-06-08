#!/bin/bash
#
   testBuild=$1
   testDB=$2
   testType=`echo $3|tr A-Z a-z`
   numSess=$4
   runTime=$5
#
   pidsFile=/tmp/queryAndDataMod.pids
   rm -f $pidsFile
#
   MYRBUILD=$testBuild
   source $MYRHOME/common/env/myrclient.sh
   $MYRHOME/myrocks/sh/resetEnvSingle.sh $MYRBUILD > resetEnvSingle.log 2>&1
#  create lineitem table
   $MYRCLIENT $testDB -f -vvv < $MYRHOME/concurrency/queryAndDataMod/sql/createLineitem.sql >> create.log 2>&1
#
# For some of the test, we need to perform initial data load
   case "$testType" in
      update|delete|ddl)
         echo 0 > continue.txt
         $MYRHOME/concurrency/queryAndDataMod/sh/cpimport.sh $testDB
      ;;
   esac
#
   echo 1 > continue.txt
#
   case "$testType" in
      ldi|update|delete|ddl)
#
# Start query scripts in n sessions
         $MYRHOME/concurrency/queryAndDataMod/sh/launchQueries.sh $testDB query.$testType.sql $numSess &
         echo $! >> $pidsFile
#
# Run test specific tasks
         $MYRHOME/concurrency/queryAndDataMod/sh/$testType.sh $testDB &
         echo $! >> $pidsFile
         ;;
#
   esac
#
   if [ "$runTime" != "" ]; then
      $MYRHOME/common/sh/waitInMinutes.sh $runTime
      echo 0 >continue.txt
      $MYRHOME/common/sh/waitForExecDone.sh $pidsFile
   fi
#
#
# Analyze log files
#
   $MYRHOME/concurrency/queryAndDataMod/sh/analyzeResults.sh $testType
   $MYRHOME/concurrency/queryAndDataMod/sh/getStatus.sh
   exit $?
