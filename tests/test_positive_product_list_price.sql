select *
from {{ ref('int_production__products') }}
where product_list_price < 0