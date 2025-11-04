with totals_per_order_per_product as (

    select
        order_created_at,
        order_id,
        customer_id,
        sum(item_quantity) as product_total_quantity,
        sum(item_net_amount) as product_total_net_amount,
        product_id,
    from {{ ref('int_sales__orders') }}
    group by product_id, order_created_at, order_id, customer_id
)

select
    p.product_id,
    p.product_name,
    p.product_model_year,
    p.product_list_price,
    p.product_category_name,
    p.product_brand_name,
    opp.order_created_at as product_order_date,
    count(distinct opp.order_id) as product_daily_total_orders,
    count(distinct opp.customer_id) as product_daily_total_customers,
    sum(opp.product_total_quantity) as product_daily_total_quantity,
    sum(opp.product_total_net_amount) as product_daily_revenue
from {{ ref('int_production__products') }} p
left join totals_per_order_per_product opp
    on p.product_id = opp.product_id
group by p.product_id, p.product_name, p.product_model_year, p.product_list_price, p.product_category_name, p.product_brand_name, opp.order_created_at
order by product_order_date, product_id