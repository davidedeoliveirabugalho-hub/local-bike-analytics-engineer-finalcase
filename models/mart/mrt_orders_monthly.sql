with monthly_totals_per_order as (

    select
        date_trunc(order_created_at, month) as order_month,
        order_id,
        customer_id,
        count(item_id) as order_distinct_items,
        sum(item_net_amount) as order_total_net_amount
    from {{ ref('int_sales__orders') }}
    group by order_month, order_id, customer_id
)

select
    order_month,
    count(distinct order_id) as monthly_total_orders,
    count(distinct customer_id) as monthly_total_customers,
    round(avg(order_distinct_items),0) as monthly_avg_distinct_items,
    round(avg(order_total_net_amount),2) as monthly_avg_basket
from monthly_totals_per_order
group by order_month
order by order_month