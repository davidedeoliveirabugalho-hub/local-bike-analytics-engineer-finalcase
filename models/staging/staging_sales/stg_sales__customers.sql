select 
    cast(customer_id as integer) as customer_id,
    cast(first_name as string) as customer_first_name,
    cast(last_name as string) as customer_last_name,
    cast(phone as string) as customer_phone,
    cast(email as string) as customer_email,
    cast(street as string) as customer_street,
    cast(city as string) as customer_city,
    cast(state as string) as customer_state,
    cast(zip_code as integer ) as customer_zip_code
from {{ source('sales_local_bike', 'customers') }}