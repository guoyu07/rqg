select 'Result' flag, min(l_orderkey), max(l_orderkey), count(*), case mod(count(*),8388608) when 0 then 'Good' when 8380416 then 'Good' else 'Bad' end as Status from lineitem;
