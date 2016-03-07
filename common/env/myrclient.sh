   if [ "$MYRBUILD" = "" ]; then
      echo "MYRBUILD" environment variable is not set.  Please set it to your target test build.
      echo Exiting.....
      exit
   fi
#
# Set some default values
#
   MYRRunMode=1
   MYRMasterPort=3306
   MYRSlave1Port=3307
   MYRMasterSocket=/tmp/mysql.socks
   MYRSlave1Socket=/tmp/repSlave1.socks
   MYRClientDir=$MYRRELHOME/$MYRBUILD/mysql-5.6/client
#
# Get settings from setup.txt file
   runMode=`cat $MYRHOME/common/env/setup.txt|grep myrRunMode|awk -F"=" '{print $2}'`
   masterPort=`cat $MYRHOME/common/env/setup.txt|grep myrMasterPort|awk -F"=" '{print $2}'`
   slave1Port=`cat $MYRHOME/common/env/setup.txt|grep myrSlave1Port|awk -F"=" '{print $2}'`
   masterSocket=`cat $MYRHOME/common/env/setup.txt|grep myrMasterSocket|awk -F"=" '{print $2}'`
   slave1Socket=`cat $MYRHOME/common/env/setup.txt|grep myrSlave1Socket|awk -F"=" '{print $2}'`
   mysqlClientDir=`cat $MYRHOME/common/env/setup.txt|grep mysqlClientDir|awk -F"=" '{print $2}'`
#
# Use settings in setup.txt file if defined
#
   if [ "$runMode" != "" ]; then
      MYRRunMode=$runMode
   fi
#
   if [ "$masterPort" != "" ]; then
      MYRMasterPort=$masterPort
   fi
#
   if [ "$slave1Port" != "" ]; then
      MYRSlave1Port=$slave1Port
   fi
#
   if [ "$masterSocket" != "" ]; then
      MYRMasterSocket=$masterSocket
   fi
#
   if [ "$slave1Socket" != "" ]; then
      MYRSlave1Socket=$slave1Socket
   fi
#
   if [ "$mysqlClientDir" != "" ]; then
      MYRclientDir=$mysqlClientDir
   fi
#
# Export variables
#
   export MYRRUNMODE=$MYRRunMode
   export MYRMASTERPORT=$MYRMasterPort
   export MYRSLAVE1PORT=$MYRSlave1Port
   export MYRMASTERSOCKET=$MYRMasterSocket
   export MYRSLAVE1SOCKET=$MYRSlave1Socket
   export MYRCLIENTDIR=$MYRClientDir
#
   export MYRCLIENT="$MYRCLIENTDIR/mysql -uroot --port=$MYRMASTERPORT --socket=/tmp/mysql.sock"
   export MYRCMASTER="$MYRCLIENTDIR/mysql -uroot --port=$MYRMASTERPORT --socket=/tmp/mysql.sock"
   export MYRCSLAVE1="$MYRCLIENTDIR/mysql -uroot --port=$MYRSLAVE1PORT --socket=/tmp/repSlave1.sock"
