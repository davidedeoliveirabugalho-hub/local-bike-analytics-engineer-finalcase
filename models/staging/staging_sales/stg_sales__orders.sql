select 
    cast(order_id as integer) as order_id,
    cast(customer_id as integer) as customer_id,
    cast(order_status as integer) as order_status,
    cast(order_date as date) as order_date,
    cast(required_date as date) as order_required_date,
    cast(shipped_date as date) as order_shipped_date,
    cast(store_id as integer) as store_id,
    cast(staff_id as integer) as staff_id
from {{ source('sales_local_bike', 'orders') }}