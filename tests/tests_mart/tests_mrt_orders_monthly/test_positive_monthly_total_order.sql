select *
from {{ ref('mrt_orders_monthly') }}
where monthly_total_orders < 0