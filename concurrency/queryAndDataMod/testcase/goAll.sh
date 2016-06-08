#!/bin/bash
# Parameters: testBuild, testDB, testType, numOfConcurrentQuerySessions, runTimeInMinutes
#
   $MYRHOME/concurrency/queryAndDataMod/test/queryAndDataMod.sh mytest test ldi 2 3
   $MYRHOME/concurrency/queryAndDataMod/test/queryAndDataMod.sh mytest test delete 2 3
   $MYRHOME/concurrency/queryAndDataMod/test/queryAndDataMod.sh mytest test ddl 2 3
   $MYRHOME/concurrency/queryAndDataMod/test/queryAndDataMod.sh mytest test update 2 3
 #
   cnt=`grep -i Failed testStatus.txt|wc -l`
   if [ $cnt = 0 ]; then
      rc=0
   else
      rc=1
   fi
   exit $rc

