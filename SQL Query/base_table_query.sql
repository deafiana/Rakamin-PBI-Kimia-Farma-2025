CREATE TABLE `rakamin-kf-analytics-455005.kimia_farma.base_table` AS 
  SELECT
    t.transaction_id,
    t.date,
    b.branch_id,
    b.branch_name,
    b.kota AS city,
    b.provinsi AS province,
    b.rating AS rating_cabang,
    t.customer_name,
    p.product_id,
    p.product_name,
    p.price AS actual_price,
    t.discount_percentage,
    CASE
      WHEN p.price <= 50000 THEN 0.10
      WHEN p.price <= 100000 THEN 0.15
      WHEN p.price <= 300000 THEN 0.20
      WHEN p.price <= 500000 THEN 0.25
      ELSE 0.30
    END AS expected_gross_profit_percentage,
    p.price * (p.price * t.discount_percentage) AS nett_sales,
    p.price - (p.price * t.discount_percentage) * 
    CASE
      WHEN p.price <= 50000 THEN 0.10
      WHEN p.price <= 100000 THEN 0.15
      WHEN p.price <= 300000 THEN 0.20
      WHEN p.price <= 500000 THEN 0.25
      ELSE 0.30
    END AS nett_profit,
    t.rating AS transaction_rating
  FROM
      `rakamin-kf-analytics-455005.kimia_farma.kf_final_transaction` t
  LEFT JOIN
      `rakamin-kf-analytics-455005.kimia_farma.kf_kantor_cabang` b
      ON t.branch_id = b.branch_id
  LEFT JOIN
      `rakamin-kf-analytics-455005.kimia_farma.kf_product` p
      ON t.product_id = p.product_id;