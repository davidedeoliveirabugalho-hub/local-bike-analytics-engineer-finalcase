select *
from {{ ref('stg_sales__orders') }}
where order_estimated_delivery_date < order_created_at