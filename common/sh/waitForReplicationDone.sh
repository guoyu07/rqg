#1 /bin/bash
#
   buildName=$1
   maxTimeout=$2
#
   MYRBUILD=reptest
   source $MYRHOME/common/env/myrclient.sh
#
   testDir=$MYRRELHOME/$buildName
   timeout=1
   cd $testDir/mysql-5.6/client

# Check for slave status every one second
   echo "" > /tmp/repStatusSlave1.txt
   for i in $(seq 1 $maxTimeout); do
      $testDir/mysql-5.6/client/mysql -uroot --port=$MYRSLAVE1PORT --socket=$MYRSLAVE1SOCKET -vvv -e "show slave status\G;" > /tmp/t.txt
      cat /tmp/t.txt >> /tmp/repStatusSlave1.txt
      status=`cat /tmp/t.txt|grep "Slave has read all relay log" |wc -l`
      if [ "$status" -eq 1 ]; then
         timeout=0
         break
      fi
      sleep 1
   done
   exit $timeout
#
     