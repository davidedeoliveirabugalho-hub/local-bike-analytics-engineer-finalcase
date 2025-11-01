select 
    cast(staff_id as integer) as staff_id,
    cast(first_name as string) as staff_first_name,
    cast(last_name as string) as staff_last_name,
    cast(email as string) as staff_email,
    cast(phone as string) as staff_phone,
    cast(active as boolean) as staff_is_active,
    cast(store_id as integer) as store_id,
    cast(manager_id as integer) as staff_manager_id
from {{ source('sales_local_bike', 'staffs') }}