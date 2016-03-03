set rocksdb_bulk_load=1;
DROP TABLE IF EXISTS lineitem;
CREATE TABLE `lineitem` (   `l_orderkey` int(11) DEFAULT NULL,   `l_partkey` int(11) DEFAULT NULL,   `l_suppkey` int(11) DEFAULT NULL,   `l_linenumber` bigint(20) DEFAULT NULL,   `l_quantity` decimal(12,2) DEFAULT NULL,   `l_extendedprice` decimal(12,2) DEFAULT NULL,   `l_discount` decimal(12,2) DEFAULT NULL,   `l_tax` decimal(12,2) DEFAULT NULL,   `l_returnflag` char(1) DEFAULT NULL,   `l_linestatus` char(1) DEFAULT NULL,   `l_shipdate` date DEFAULT NULL,   `l_commitdate` date DEFAULT NULL,   `l_receiptdate` date DEFAULT NULL,   `l_shipinstruct` char(25) DEFAULT NULL,   `l_shipmode` char(10) DEFAULT NULL,   `l_comment` varchar(44) DEFAULT NULL,   `id` int(11) NOT NULL AUTO_INCREMENT,   PRIMARY KEY (id, l_orderkey),   KEY (id) ) ENGINE=ROCKSDB DEFAULT CHARSET=latin1;
#
# load 10000 lineitem table
#
load data infile "/tmp/lineitem.tbl" into table lineitem fields terminated by "|";
#
# update l_linenumber to 0 and use it as a counter
#
update lineitem set l_linenumber = 0;
set rocksdb_bulk_load=0;