select 
t1.purchase_date,
coalesce(SUM(t1.amount+t2.amount), 0) AS amount
from
(
  select DATE_FORMAT(a.Date,'%Y-%m-%d') as purchase_date,
  '0' as  amount
  from (
    select curdate() - INTERVAL (a.a + (10 * b.a) + (100 * c.a)) DAY as Date
    from (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as a
    cross join (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as b
    cross join (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as c
  ) a
  where a.Date BETWEEN NOW() - INTERVAL 7 DAY AND NOW()
)t1
left join
(
  SELECT DATE_FORMAT(purchase_date, '%Y-%m-%d') as purchase_date,
  coalesce(SUM(amount), 0) AS amount
  FROM transactions
  WHERE purchase_date BETWEEN NOW() - INTERVAL 7 DAY AND NOW()
  AND vendor_id = 0
  GROUP BY purchase_date
)t2
on t2.purchase_date = t1.purchase_date
group by t1.purchase_date
order by t1.purchase_date desc
