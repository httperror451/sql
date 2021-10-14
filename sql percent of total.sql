SELECT Rep, Sale, Sale * 100 / t.s AS `percent of total`
FROM sales
CROSS JOIN (SELECT SUM(sale) AS s FROM sales) t;
