#!/bin/bash
#
   testDB=$1
   scriptCnt=$2
   tableCnt=$3
   columnCnt=$4
#
   $IDBATPHOME/systemTest/concurrentDML/sh/genDDLScript.sh $scriptCnt $tableCnt $columnCnt
#
   rm -f ddl.pids.txt
   for ((i=1; $i<=$scriptCnt; i++)); do
      $IDBCLIENT $testDB -vvv -f <DDLTest$i.sql > DDLTest$i.log 2>&1 &
      echo $! >> ddl.pids.txt
   done
#
   $IDBATPHOME/common/sh/waitForExecDone.sh ddl.pids.txt
#
   $IDBCLIENT calpontsys --skip-column-name <DDLTestListOIDs.sql > DDLTestListOIDs.log 2>&1
   $IDBCLIENT calpontsys --skip-column-name <DDLTestCountOIDs.sql > DDLTestCountOIDs.log 2>&1
   $IDBCLIENT calpontsys --skip-column-name <DDLTestCountDistinctOIDs.sql > DDLTestCountDistinctOIDs.log 2>&1
   $IDBCLIENT $testDB -vvv -f <DDLTestDropTables.sql > DDLTestDropTables.log 2>&1
#
   expectedOIDCnt=$(($scriptCnt*$tableCnt*$columnCnt))
   testOIDCnt=`cat DDLTestCountOIDs.log`
   testOIDCntDistinct=`cat DDLTestCountDistinctOIDs.log`
#
   if [ $expectedOIDCnt = $testOIDCnt ] && [ $expectedOIDCnt = $testOIDCntDistinct ]; then
      status=Passed
   else
      status=Failed
   fi   
   echo $status expected=$expectedOIDCnt   cnt=$testOIDCnt  distCnt=$testOIDCntDistinct  > DDLTestStatus.txt
