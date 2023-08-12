WITH array(toDate('2023-07-01'), toDate('2023-07-31')) AS report_dates   -- change this dates if you want to get 
                                                                         -- data mart for another month
SELECT
	sps.shop_name,
	prs.product_name,
	fts.sales_cnt AS sales_fact,
	pl.plan_cnt AS sales_plan,
	toDecimal64(fts.sales_cnt / pl.plan_cnt, 2) AS sales_ratio,
	fts.sales_cnt * prs.price AS income_fact,
	pl.plan_cnt * prs.price AS income_plan,
	(fts.sales_cnt * prs.price) / (pl.plan_cnt * prs.price) AS income_ratio
FROM 
	shops sps
	JOIN plan pl ON sps.shop_id = pl.shop_id
	JOIN products prs ON pl.product_id = prs.product_id,
	(
	    WITH array(toDate('2023-07-01'), toDate('2023-07-31')) AS report_dates   -- change this dates if you want to get 
                                                                         		 -- data mart for another month
        SELECT
			'dns' AS shop_name,
			sd.product_id,
			SUM(sd.sales_cnt) AS sales_cnt
		FROM shop_dns sd
        WHERE sd."date" >= report_dates[1] AND 
			  sd."date" <= report_dates[2]
		GROUP BY sd.product_id
		UNION ALL
		SELECT
			'mvideo' AS shop_name,
			sm.product_id,
			SUM(sm.sales_cnt) AS sales_cnt
		FROM shop_mvideo sm
        WHERE sm."date" >= report_dates[1] AND 
			  sm."date" <= report_dates[2]
		GROUP BY sm.product_id
		UNION ALL
		SELECT
			'sitilink' AS shop_name,
			ss.product_id,
			SUM(ss.sales_cnt) AS sales_cnt
		FROM shop_sitilink ss
        WHERE ss."date" >= report_dates[1] AND 
			  ss."date" <= report_dates[2]
		GROUP BY ss.product_id 
		) AS fts				-- fact sales 
WHERE
	sps.shop_name = fts.shop_name AND 
	prs.product_id = fts.product_id AND
	pl.plan_date >= report_dates[1] AND 
	pl.plan_date <= report_dates[2] 