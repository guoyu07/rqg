#!/bin/bash
#
   testDB=$1
#
#  1st partition always skip blocks.  In the case of lineitem, 8192 rows.
#
# From 2nd partition and on, we don't need to skip block since each job loads exact number of rows to fill one partition.
# All columns with different  width advance to the next block, which is in the next extent.
# No blocks are being skipped
#
   $IDBINSHOME/bin/cpimport $testDB lineitem $MYRHOME/data/source/tpch/other/lineitem1stPartition.tbl>> cpimport.og 2>&1
   keepGoing=1
   while [ $keepGoing -eq 1 ]; do
      $IDBINSHOME/bin/cpimport $testDB lineitem $MYRHOME/data/source/tpch/other/lineitemOtherPartition.tbl>> cpimport.og 2>&1
      if [ -f continue.txt ]; then
          keepGoing=`cat continue.txt`
      fi
      sleep 120
   done

