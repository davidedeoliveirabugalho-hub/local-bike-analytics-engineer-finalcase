select *
from {{ ref('mrt_products_stocks_vs_sales_monthly') }}
where nb_months_sold < 0