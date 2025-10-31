select 
    cast(brand_id as integer) as brand_id,
    cast(brand_name as string) as brand_name
from {{ source('production_local_bike', 'brands') }}