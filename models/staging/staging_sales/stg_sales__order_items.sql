select 
    CONCAT(order_id, '_', item_id) AS order_item_id,
    cast(order_id as integer) as order_id,
    cast(item_id as integer) as item_id,
    cast(product_id as integer) as product_id,
    cast(quantity as integer) as item_quantity,
    cast(list_price as numeric) as item_list_price,
    cast(discount as numeric) as item_discount
from {{ source('sales_local_bike', 'order_items') }}