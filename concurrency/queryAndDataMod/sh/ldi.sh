#!/bin/bash
#
   testDB=$1
#
   head -n 850000 $MYRHOME/data/source/tpch/1g/lineitem.tbl > /tmp/ldi.tbl
   keepGoing=1
   while [ $keepGoing -eq 1 ]; do
      $MYRCLIENT $testDB -f -vvv < $MYRHOME/concurrency/queryAndDataMod/sql/ldi.sql >> ldi.log 2>&1
      if [ -f continue.txt ]; then
          keepGoing=`cat continue.txt`
      fi
   done

