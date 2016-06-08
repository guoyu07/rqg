#!/bin/bash
#
   $MYRHOME/common/sh/getStatus.sh
   cnt=`grep -i Failed testStatus.txt|wc -l`
   if [ $cnt = 0 ]; then
      status=Passed
      rc=0
   else
      status=Failed
      rc=1
   fi
   echo $status > status.txt
   exit $rc
