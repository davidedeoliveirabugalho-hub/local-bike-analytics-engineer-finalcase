select 
    cast(order_id as integer) as order_id,
    cast(customer_id as integer) as customer_id,
    cast(order_status as integer) as order_status,
    cast(order_date as date) as order_created_at,
    cast(required_date as date) as order_estimated_delivery_date,
    cast(nullif(shipped_date, 'NULL') as date) as order_shipped_at,
    cast(store_id as integer) as store_id,
    cast(staff_id as integer) as staff_id
from {{ source('sales_local_bike', 'orders') }}