select *
from {{ ref('mrt_orders_daily') }}
where daily_total_customers < 0