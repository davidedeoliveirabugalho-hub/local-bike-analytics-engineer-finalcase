select *
from {{ ref('stg_sales__orders') }}
where order_shipped_at is not null and order_shipped_at < order_created_at