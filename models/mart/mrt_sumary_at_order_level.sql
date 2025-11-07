with totals_per_order_per_store as (

    select
        order_created_at,
        order_id,
        count(item_id) as order_distinct_items,
        sum(item_net_amount) as order_total_net_amount,
        o.store_id,
        o.staff_id,
        concat(upper(substr(staff_first_name, 1, 1)), lower(substr(staff_first_name, 2)), 
                ' ', upper(staff_last_name)
                ) as staff_name,
        staff_is_active,
        staff_manager_id,
        staff_role
    from {{ ref('int_sales__orders') }} o
    left join {{ ref('int_sales__staffs') }} s
        on o.staff_id = s.staff_id
    group by order_id, 
        store_id,  
        staff_id,
        order_created_at, 
        staff_name,
        staff_is_active,
        staff_manager_id,
        staff_role
)

select
    ops.order_id as order_id,
    s.store_id as store_id,
    s.store_name as store_name,
    s.store_state as store_state,
    d.calendar_date as calendar_date,
    coalesce(ops.order_distinct_items, 0) as order_distinct_items,
    coalesce(sum(ops.order_total_net_amount), 0) as order_revenue,
    ops.staff_id as staff_id,
    ops.staff_name as staff_name,
    ops.staff_is_active as staff_is_active,
    ops.staff_manager_id as staff_manager_id,
    ops.staff_role as staff_role,
    d.calendar_year as calendar_year,
    d.calendar_month as calendar_month,
    d.calendar_week_number as calendar_week_number,
    d.calendar_day as calendar_day,
    d.calendar_day_of_week as calendar_day_of_week,
    d.is_weekend as is_weekend
from {{ ref('int_dates') }} d
cross join {{ ref('stg_sales__stores') }} s
left join totals_per_order_per_store ops
    on d.calendar_date = ops.order_created_at 
    and s.store_id = ops.store_id
group by 
    order_id,
    store_id,
    staff_id, 
    store_name, 
    store_state, 
    d.calendar_date,
    staff_name,
    staff_is_active,
    staff_manager_id,
    staff_role,
    order_distinct_items,
    d.calendar_year,
    d.calendar_month,
    d.calendar_week_number,
    d.calendar_day,
    d.calendar_day_of_week,
    d.is_weekend
order by calendar_date,
        store_id
