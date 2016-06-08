#!/bin/bash
#
   testDB=$1
#
   keepGoing=1
   while [ $keepGoing -eq 1 ]; do
      $IDBINSHOME/bin/cpimport $testDB lineitem $MYRHOME/data/source/tpch/10g/lineitem.tbl >> cpimport.log 2>&1
      if [ -f continue.txt ]; then
          keepGoing=`cat continue.txt`
      fi
   done

