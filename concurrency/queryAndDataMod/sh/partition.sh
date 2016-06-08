#!/bin/bash
#
   testDB=$1
   pidsFile=/tmp/partitionDrop.pids
#
# Launch cpimport
   $MYRHOME/concurrency/queryAndDataMod/sh/partitionCpimport.sh $testDB &
   echo $! >> $pidsFile

# Launch partition operations
   $MYRHOME/concurrency/queryAndDataMod/sh/partitionDrop.sh $testDB &
   echo $! >> $pidsFile
#
# Wait for back ground processes to finish
#
  $MYRHOME/common/sh/waitForExecDone.sh $pidsFile
  rm -rf $pidsFile

