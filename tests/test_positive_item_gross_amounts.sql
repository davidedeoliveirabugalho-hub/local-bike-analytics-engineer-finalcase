select *
from {{ ref('int_sales__orders') }}
where item_gross_amount < 0