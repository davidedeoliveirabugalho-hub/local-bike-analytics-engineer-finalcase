with totals_per_order_per_seller as (

    select
        order_created_at,
        order_id,
        customer_id,
        count(item_id) as order_distinct_items,
        sum(item_net_amount) as order_total_net_amount,
        staff_id
    from {{ ref('int_sales__orders') }}
    group by staff_id, order_created_at, order_id, customer_id
)

select
    s.staff_id as staff_id,
    s.staff_first_name as staff_first_name,
    s.staff_last_name as staff_last_name,
    s.staff_is_active as staff_is_active,
    s.store_id as store_id,
    s.staff_manager_id as staff_manager_id,
    s.staff_role as staff_role,
    s.is_salesperson as is_salesperson,
    d.calendar_date as calendar_date,
    coalesce(count(distinct ops.order_id), 0) as seller_daily_total_orders,
    coalesce(count(distinct ops.customer_id), 0) as seller_daily_total_customers,
    round(avg(ops.order_distinct_items),0) as seller_daily_avg_distinct_items,
    sum(ops.order_total_net_amount) as seller_daily_revenue,
    round(avg(ops.order_total_net_amount),2) as seller_daily_avg_basket,
    d.calendar_year as calendar_year,
    d.calendar_month as calendar_month,
    d.calendar_week_number as calendar_week_number,
    d.calendar_day as calendar_day,
    d.calendar_day_of_week as calendar_day_of_week,
    d.is_weekend as is_weekend
from {{ ref('int_dates') }} d
cross join {{ ref('int_sales__staffs') }} s
left join totals_per_order_per_seller ops
    on d.calendar_date = ops.order_created_at 
    and s.staff_id = ops.staff_id
group by 
    staff_id,
    staff_first_name,
    staff_last_name,
    staff_is_active,
    store_id,
    staff_manager_id,
    staff_role,
    is_salesperson,
    d.calendar_date,
    d.calendar_year,
    d.calendar_month,
    d.calendar_week_number,
    d.calendar_day,
    d.calendar_day_of_week,
    d.is_weekend
order by calendar_date,
        staff_id