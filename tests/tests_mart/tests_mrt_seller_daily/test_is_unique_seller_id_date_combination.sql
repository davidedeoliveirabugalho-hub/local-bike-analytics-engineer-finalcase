select COUNT(*) AS nbr_duplicate,
        staff_id,
        calendar_date
from {{ ref('mrt_sales_by_seller_daily') }}
group by staff_id,
        calendar_date
having COUNT(*) > 1