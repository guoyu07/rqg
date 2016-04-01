#1 /bin/bash
#
   buildName=$1
   maxTimeout=$2
#
   MYRBUILD="setup"
   source $MYRHOME/common/env/myrclient.sh
#
   testDir=$MYRRELHOME/$MYRBUILD
   timeout=1
   cd $testDir/mysql-5.6/client
#
# get replication master binlog position
   ./mysql -uroot --port=$MYRMASTERPORT --socket=$MYRMASTERSOCKET -vvv -e "show master status;" > /tmp/t.txt
   masterBinlogPos=`cat /tmp/t.txt |grep "mysql-bin"|awk -F" " '{ print $4 }'`
#
# Check for slave status every one second
   rm -f /tmp/repStatusSlave1.txt
   for i in $(seq 1 $maxTimeout); do
      ./mysql -uroot --port=$MYRSLAVE1PORT --socket=$MYRSLAVE1SOCKET -vvv -e "show slave status\G;" > /tmp/t.txt
      cat /tmp/t.txt >> /tmp/repStatusSlave1.txt
      slave1BinlogExecPos=`cat /tmp/t.txt |grep Exec_Master_Log_Pos|awk -F" " '{ print $2 }'`
      echo masterBinlogPos="$masterBinlogPos" slave1BinlogExecPos="$slave1BinlogExecPos" >> /tmp/repStatusSlave1.txt
      if [ "$masterBinlogPos" = "$slave1BinlogExecPos" ]; then
         timeout=0
         break
      fi
      sleep 1
   done
# Add 5 extra seconds for replication to complete
   sleep 5
   exit $timeout
#
     