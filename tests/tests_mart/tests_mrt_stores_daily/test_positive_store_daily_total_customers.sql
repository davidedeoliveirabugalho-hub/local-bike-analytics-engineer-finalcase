select *
from {{ ref('mrt_sales_by_store_daily') }}
where store_daily_total_customers < 0