select 
    cast(staff_id as integer) as staff_id,
    cast(first_name as string) as staff_first_name,
    cast(last_name as string) as staff_last_name,
    cast(email as string) as staff_email,
    cast(phone as string) as staff_phone,
    cast(active as boolean) as staff_is_active,
    coalesce(safe_cast(manager_id as integer), 0) as staff_manager_id,
    coalesce(safe_cast(store_id as integer), 0) as store_id
from {{ source('sales_local_bike', 'staffs') }}