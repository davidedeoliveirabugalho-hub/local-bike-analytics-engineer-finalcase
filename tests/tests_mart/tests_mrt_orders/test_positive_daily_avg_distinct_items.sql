select *
from {{ ref('mrt_orders_daily') }}
where daily_avg_distinct_items < 0