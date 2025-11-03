with totals_per_order as (

    select
        order_created_at,
        order_id,
        customer_id,
        count(item_id) as order_distinct_items,
        sum(item_net_amount) as order_total_net_amount
    from {{ ref('int_sales__orders') }}
    group by order_id, order_created_at, customer_id
)

select
    order_created_at,
    count(distinct order_id) as daily_total_orders,
    count(distinct customer_id) as daily_total_customers,
    avg(order_distinct_items) as daily_avg_distinct_items,
    avg(order_total_net_amount) as daily_avg_basket
from totals_per_order
group by order_created_at