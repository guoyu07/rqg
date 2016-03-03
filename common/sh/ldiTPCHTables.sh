#!/bin/bash
#
   if [ $# -ne 2 ]; then
      echo Usage: $0 dbName dbSize
      echo Exiting.....
      exit 1
   fi
#
function createLDIStatement {
   tableName=$1
#   
   echo load data infile \"$MYRHOME/data/tpch/$dbSize/$tableName.tbl\" into table $tableName fields terminated by \"\|\"\; >> /tmp/ldi.sql
}

   dbName=$1
   dbSize=$2
#
   echo set rocksdb_bulk_load=1\; > /tmp/ldi.sql
   createLDIStatement nation
   createLDIStatement region
   createLDIStatement customer
   createLDIStatement orders
   createLDIStatement part
   createLDIStatement supplier
   createLDIStatement partsupp
   createLDIStatement lineitem
   echo set rocksdb_bulk_load=0\; >> /tmp/ldi.sql
#   
   source $MYRHOME/common/env/myrclient.sh
#
  $MYRCLIENT $dbName -f -vvv < /tmp/ldi.sql > ldiTPCHTables.log 2>&1
#echo $MYRCLIENT
