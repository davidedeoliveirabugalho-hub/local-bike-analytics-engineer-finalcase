select *
from {{ ref('mrt_orders_daily') }}
where daily_total_orders < 0