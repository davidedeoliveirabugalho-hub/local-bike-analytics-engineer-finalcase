select 
    cast(store_id as integer) as store_id,
    cast(store_name as string) as store_name,
    cast(phone as string) as store_phone,
    cast(email as string) as store_email,
    cast(street as string) as store_street,
    cast(city as string) as store_city,
    cast(state as string) as store_state,
    cast(zip_code as integer) as store_zip_code
from {{ source('sales_local_bike', 'stores') }}