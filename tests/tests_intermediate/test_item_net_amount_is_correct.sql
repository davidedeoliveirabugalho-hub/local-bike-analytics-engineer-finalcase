select *
from {{ ref('int_sales__orders') }}
where item_net_amount <> (item_gross_amount - item_discount_amount)