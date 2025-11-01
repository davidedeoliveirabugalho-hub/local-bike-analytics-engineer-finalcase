with manager_list AS (

    select
        distinct staff_manager_id as distinct_manager_id
    from {{ ref('stg_sales__staffs') }}
    where staff_manager_id is not null

),

hierarchical_role as (

    select
        staff_id,
        case
            when staff_manager_id is null and staff_id in (select distinct_manager_id from manager_list)
                then "general_manager"
            when staff_manager_id is not null and staff_id in (select distinct_manager_id from manager_list)
                then "store_manager"
            else "seller"
        end as staff_role
    from {{ ref('stg_sales__staffs') }}
),

sellers_list as (

    select
        s.staff_id,
        count(o.order_id) as staff_total_orders
    from {{ ref('stg_sales__staffs') }} as s
        left join {{ ref('stg_sales__orders') }} as o 
            ON s.staff_id = o.staff_id
    group by s.staff_id
),

salespersons_list as (

    select
        staff_id,
        staff_total_orders,
        case
            when staff_total_orders > 0 then TRUE
            else FALSE
        end as is_salesperson
    from sellers_list
)

select
    s.staff_id,
    s.staff_first_name,
    s.staff_last_name,
    s.staff_is_active,
    s.store_id,
    s.staff_manager_id,
    hr.staff_role,
    sp.is_salesperson,
    sp.staff_total_orders
from {{ ref('stg_sales__staffs') }} as s
    left join hierarchical_role as hr
        on s.staff_id = hr.staff_id
    left join salespersons_list as sp
        on s.staff_id = sp.staff_id
order by 
    s.staff_id