select COUNT(*) AS nbr_duplicate,
        product_id,
        product_order_date
from {{ ref('mrt_sales_by_product_daily') }}
group by product_id,
        product_order_date
having COUNT(*) > 1