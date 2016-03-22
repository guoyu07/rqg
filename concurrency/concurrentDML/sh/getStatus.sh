#!/bin/bash
#
   lastLine=`tail -1 testStatus.txt`
   if [ "$lastLine" = "0 total" ]; then
      echo Passed > status.txt
   else
      echo Failed > status.txt
   fi

