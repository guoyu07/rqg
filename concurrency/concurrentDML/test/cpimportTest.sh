#!/bin/bash
#
   testDB=$1
   dbSize=$2
   numIter=$3
#
#  Truncate TPCH tables before cpimporting
#
   $IDBCLIENT $testDB -vvv -f <$IDBATPHOME/common/sql/truncateTPCHTables.sql > truncateTableRowCounts.log 2>&1
#
   for ((i=1; $i<=$numIter; i++)); do
      rm -f cpimportpids.txt
      cat $IDBATPHOME/systemTest/concurrentDML/data/tpchTableList.txt |
      while read tableName restoftheline; do
         $IDBINSHOME/bin/cpimport -m 1 $testDB $tableName $IDBATPHOME/data/source/tpch/$dbSize\g/$tableName.tbl > cpimport$tableName$i.log 2>&1 &
         echo $! >> cpimportpids.txt
      done
#
      $IDBATPHOME/common/sh/waitForExecDone.sh cpimportpids.txt
#
      $IDBCLIENT $testDB -f <$IDBATPHOME/common/sql/countTPCHTables.sql > cpimportTableRowCounts$i.log 2>&1
      cat cpimportTableRowCounts$i.log |grep -v count > cpimportRowCnts$i.Test.txt
      cat $IDBATPHOME/common/data/TPCHTableRowCounts.txt | grep $dbSize\gb |awk '{print $3}' > cpimportRowCnts$i.ref.txt
   done
