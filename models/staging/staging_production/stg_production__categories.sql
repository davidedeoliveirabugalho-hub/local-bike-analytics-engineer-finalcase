select 
    cast(category_id as integer) as category_id,
    cast(category_name as string) as category_name
from {{ source('production_local_bike', 'categories') }}