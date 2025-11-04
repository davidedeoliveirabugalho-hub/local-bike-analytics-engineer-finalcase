select COUNT(*) AS nbr_duplicate,
        product_id,
        store_id
from {{ ref('mrt_products_stocks_vs_sales_monthly') }}
group by product_id,
        store_id
having COUNT(*) > 1