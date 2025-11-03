with totals_per_order_per_store as (

    select
        order_created_at,
        order_id,
        customer_id,
        count(item_id) as order_distinct_items,
        sum(item_net_amount) as order_total_net_amount,
        store_id
    from {{ ref('int_sales__orders') }}
    group by store_id, order_created_at, order_id, customer_id
)

select
    s.store_id as store_id,
    s.store_name as store_name,
    s.store_state as store_state,
    d.calendar_date as calendar_date,
    coalesce(count(distinct ops.order_id), 0) as store_daily_total_orders,
    coalesce(count(distinct ops.customer_id), 0) as store_daily_total_customers,
    round(avg(ops.order_distinct_items),0) as store_daily_avg_distinct_items,
    sum(ops.order_total_net_amount) as store_daily_revenue,
    round(avg(ops.order_total_net_amount),2) as store_daily_avg_basket,
    d.calendar_year as calendar_year,
    d.calendar_month as calendar_month,
    d.calendar_week_number as calendar_week_number,
    d.calendar_day as calendar_day,
    d.calendar_day_of_week as calendar_day_of_week,
    d.is_weekend as is_weekend,
from {{ ref('int_dates') }} d
cross join {{ ref('stg_sales__stores') }} s
left join totals_per_order_per_store ops
    on d.calendar_date = ops.order_created_at 
    and s.store_id = ops.store_id
group by 
    store_id, 
    store_name, 
    store_state, 
    d.calendar_date,
    d.calendar_year,
    d.calendar_month,
    d.calendar_week_number,
    d.calendar_day,
    d.calendar_day_of_week,
    d.is_weekend
order by calendar_date,
        store_id