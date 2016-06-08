#!/bin/bash
#
   testDB=$1
   tableName=lineitem
   minPartitionsToKeep=2
#
# testMode     1=disable before job     2=just drop      3=mixed operations randomly (enable, disable, drop)
#
   testMode=1
#
   keepGoing=1
   echo $minPartitionsToKeep > /tmp/minPartitionsToKeep.txt
   echo $testMode > /tmp/testMode.txt
   date >> partitionDrop.log
   echo minPartitionsToKeep=$minPartitionsToKeep >> partitionDrop.log
#
   while [ $keepGoing -eq 1 ]; do
      $MYRHOME/common/sh/getPartitionStats.sh $testDB $tableName
      rm -rf *.par
#
      totalPartitions=`cat enabled.txt disabled.txt |wc -l`
#
      minPartitionsToKeep=`cat /tmp/minPartitionsToKeep.txt`
      testMode=`cat /tmp/testMode.txt`
#
# use testMode overwrite if exists
#
      if [ -f testMode.txt ]; then
         testMode=`cat testMode.txt`
      fi
#
      if [ $totalPartitions -gt $minPartitionsToKeep ]; then
         date >> partitionDrop.log
         cat disabled.txt enabled.txt >> partitionDrop.log
         echo TotalPartitions=$totalPartitions >> partitionDrop.log
#
         case $testMode in
            1)
               numDisabled=`cat disabled.txt|wc -l`
               case $numDisabled in
                  0)
                     partitionNum=`head -n 1 enabled.txt|awk -F" " '{print $1}'`
                     $MYRCLIENT $testDB -vvv -e "select caldisablepartition('$tableName',$partitionNum);" >> partitionDrop.log 2>&1 
                     ;;
                  *)
                     partitionNum=`head -n 1 disabled.txt|awk -F" " '{print $1}'`
                     $MYRCLIENT $testDB -vvv -e "select caldroppartition('$tableName',$partitionNum);" >> partitionDrop.log 2>&1
                     ;;
               esac
               ;;
            2)
               partitionNum=`head -n 1 enabled.txt|awk -F" " '{print $1}'`
               $MYRCLIENT $testDB -vvv -e "select caldroppartition('$tableName',$partitionNum);" >> partitionDrop.log 2>&1 
               ;;
            3)
               partitionNum=`cat random.txt`
#
# Randomly determine what partition operation to carry out (enable, disable, or drop)
#
               commandIdx=$(($RANDOM % 3))
               case $commandIdx in
                  0)
                     $MYRCLIENT $testDB -vvv -e "select calenablepartition('$tableName',$partitionNum);" >> partitionDrop.log 2>&1 
                     ;;
                  1)
                     $MYRCLIENT $testDB -vvv -e "select caldisablepartition('$tableName',$partitionNum);" >> partitionDrop.log 2>&1 
                     ;;
                  2)
                     $MYRCLIENT $testDB -vvv -e "select caldroppartition('$tableName',$partitionNum);" >> partitionDrop.log 2>&1 
                     ;;
               esac
               ;;
         esac
      fi
#
      sleep 5
#
      if [ -f continue.txt ]; then
          keepGoing=`cat continue.txt`
      fi
   done
