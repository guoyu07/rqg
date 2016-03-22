#!/bin/bash
#
#-------------------MYRHOME/concurrency------------------------------------------------------------------------------
#
# Usage: DMLTest.sh dbName dmlCommand testMode numIter
#        buildName  = build of MyRocks to be tested
#        dbName     = name of database to be tested in
#        dmlCommand = update, delete, or ldi
#        testMode   = commit     = commit at the of SQL script
#                     rollback   = rollback at the end of SQL script
#                     commiteach = commit after each DML statement
#                     rollback   = rollback after each statement
#                     default    = default behavior controlled by the autocommit variable.
#        numIter    = number of test iterations
# Generate a script to of dmlCommands for each of the TPCH tables
# Execute the scripts in 8 sessions, one for each table
# Repeat the test for numIter times
#
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test update commit 1
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test update commiteach 1
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test update rollback 1
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test update rollbackeach 1
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test update default 1
#
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test delete commit 1
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test delete commiteach 1
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test delete rollback 1
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test delete rollbackeach 1
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test delete default 1
#
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test ldi commit 1
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test ldi commiteach 1
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test ldi rollback 1
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test ldi rollbackeach 1
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test ldi default 1
#
