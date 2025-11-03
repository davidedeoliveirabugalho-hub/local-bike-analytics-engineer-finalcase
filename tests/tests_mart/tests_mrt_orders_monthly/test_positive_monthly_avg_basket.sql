select *
from {{ ref('mrt_orders_monthly') }}
where monthly_avg_basket < 0