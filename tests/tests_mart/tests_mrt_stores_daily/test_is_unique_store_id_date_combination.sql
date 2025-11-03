select COUNT(*) AS nbr_duplicate,
        store_id,
        calendar_date
from {{ ref('mrt_sales_by_store_daily') }}
group by store_id,
        calendar_date
having COUNT(*) > 1
