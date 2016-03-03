if [ "$MYRBUILD" = "" ]; then
   echo "MYRBUILD" environment variable is not set.  Please set it to your target test build.
   echo Exiting.....
   exit
fi
#
export MYRMASTERPORT=`cat $MYRHOME/common/env/setup.txt|grep myrMasterPort|awk -F"=" '{print $2}'`
export MYRSLAVE1PORT=`cat $MYRHOME/common/env/setup.txt|grep myrSlave1Port|awk -F"=" '{print $2}'`
#
export MYRCLIENTDIR=$MYRRELHOME/$MYRBUILD/mysql-5.6/client
export MYRCLIENT="$MYRCLIENTDIR/mysql -uroot --port=$MYRMASTERPORT --socket=/tmp/mysql.sock"
export MYRCMASTER="$MYRCLIENTDIR/mysql -uroot --port=$MYRMASTERPORT --socket=/tmp/mysql.sock"
export MYRCSLAVE1="$MYRCLIENTDIR/mysql -uroot --port=$MYRSLAVE1PORT --socket=/tmp/repSlave1.sock"
