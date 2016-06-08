select 'Result0' flag, min(l_suppkey), max(l_suppkey), count(*) from lineitem where l_orderkey >= 0 and l_orderkey <= 6000000;
select 'Result1' flag, min(l_suppkey), max(l_suppkey), count(*) from lineitem where l_orderkey >= 6000001 and l_orderkey <= 12000000;
select 'Result2' flag, min(l_suppkey), max(l_suppkey), count(*) from lineitem where l_orderkey >= 12000001 and l_orderkey <= 18000000;
select 'Result3' flag, min(l_suppkey), max(l_suppkey), count(*) from lineitem where l_orderkey >= 18000001 and l_orderkey <= 24000000;
select 'Result4' flag, min(l_suppkey), max(l_suppkey), count(*) from lineitem where l_orderkey >= 24000001 and l_orderkey <= 30000000;
select 'Result5' flag, min(l_suppkey), max(l_suppkey), count(*) from lineitem where l_orderkey >= 30000001 and l_orderkey <= 36000000;
select 'Result6' flag, min(l_suppkey), max(l_suppkey), count(*) from lineitem where l_orderkey >= 36000001 and l_orderkey <= 42000000;
select 'Result7' flag, min(l_suppkey), max(l_suppkey), count(*) from lineitem where l_orderkey >= 42000001 and l_orderkey <= 48000000;
select 'Result8' flag, min(l_suppkey), max(l_suppkey), count(*) from lineitem where l_orderkey >= 48000001 and l_orderkey <= 54000000;
select 'Result9' flag, min(l_suppkey), max(l_suppkey), count(*) from lineitem where l_orderkey >= 54000001 and l_orderkey <= 60000000;


