#!/bin/bash
#
   if [ $# -ne 1 ]; then
      echo Usage: $0 testDB
      echo Exiting.....
      exit 1
   fi
#
   testDB=$1
   source $MYRHOME/common/env/myrclient.sh
#
  $MYRCLIENT $testDB -f -vvv < $MYRHOME/common/sql/createTPCHTables.sql > createTPCHTables.log 2>&1
  $MYRHOME/common/sh/ldiTPCHTables.sh test 1g


