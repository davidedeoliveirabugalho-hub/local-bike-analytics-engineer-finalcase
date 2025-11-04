select *
from {{ ref('mrt_products_stocks_vs_sales_monthly') }}
where avg_monthly_qty < 0