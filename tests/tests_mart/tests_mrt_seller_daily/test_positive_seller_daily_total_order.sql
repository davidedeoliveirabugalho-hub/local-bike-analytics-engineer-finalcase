select *
from {{ ref('mrt_sales_by_seller_daily') }}
where seller_daily_total_orders < 0