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
   numIter=5
#   
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test update commit $numIter
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test update commiteach $numIter
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test update rollback $numIter
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test update rollbackeach $numIter
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test update default $numIter
#
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test delete commit $numIter
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test delete commiteach $numIter
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test delete rollback $numIter
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test delete rollbackeach $numIter
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test delete default $numIter
#
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test ldi commit $numIter
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test ldi commiteach $numIter
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test ldi rollback $numIter
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test ldi rollbackeach $numIter
   $MYRHOME/concurrency/concurrentDML/test/DMLTest.sh mytest test ldi default $numIter
#
