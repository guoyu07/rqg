#!/bin/bash
#
   testDB=$1
#
   keepGoing=1
   while [ $keepGoing -eq 1 ]; do
      $MYRCLIENT $testDB -f -vvv < $MYRHOME/concurrency/queryAndDataMod/sql/ddl.sql >> ddl.log 2>&1
      if [ -f continue.txt ]; then
          keepGoing=`cat continue.txt`
      fi
   done

