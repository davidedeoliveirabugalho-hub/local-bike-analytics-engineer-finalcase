select *
from {{ ref('mrt_orders_daily') }}
where daily_avg_basket < 0