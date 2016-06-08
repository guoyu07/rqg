select 'Result' flag, min(l_orderkey), max(l_orderkey), count(*), case mod(count(*),59986052) when 0 then 'Good' else 'Bad' end from lineitem;


