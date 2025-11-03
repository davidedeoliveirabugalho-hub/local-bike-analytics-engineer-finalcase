select *
from {{ ref('int_sales__orders') }}
where item_net_amount < 0