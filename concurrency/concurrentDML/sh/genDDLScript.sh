#!/bin/bash
#
   scriptCnt=$1
   tableCnt=$2
   columnCnt=$3
#
   rm -f oidBitmapTest*.sql

   for ((i=1; $i<=$scriptCnt; i++)); do
      for ((j=1; $j<=$tableCnt; j++)); do
         echo create table ddltest$i\_$j \( >> DDLTest$i.sql
#
         for ((k=1; $k<=$columnCnt; k++)); do
            if [ $k -eq $columnCnt ]; then
               comma=""
            else
               comma=","
            fi
            echo c$k int$comma >> DDLTest$i.sql
         done
#
         echo \) engine=RocksDB\; >> DDLTest$i.sql
         echo drop table if exists ddltest$i\_$j\;>> DDLTestDropTables.sql
      done
   done
#
