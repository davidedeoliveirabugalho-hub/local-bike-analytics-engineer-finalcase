select 
    CONCAT(store_id, '_', product_id) AS product_store_id,
    cast(store_id as integer) as store_id,
    cast(product_id as integer) as product_id,
    cast(quantity as integer) as stock_quantity
from {{ source('production_local_bike', 'stocks') }}