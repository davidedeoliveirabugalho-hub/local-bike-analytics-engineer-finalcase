select 
    cast(product_id as integer) as product_id,
    cast(product_name as string) as product_name,
    cast(brand_id as integer) as product_brand_id,
    cast(category_id as integer) as product_category_id,
    cast(model_year as integer) as product_model_year,
    cast(list_price as numeric) as product_list_price
from {{ source('production_local_bike', 'products') }}