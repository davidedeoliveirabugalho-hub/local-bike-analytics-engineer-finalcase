with calculation_of_amounts as (

    select
        order_item_id,
        (item_list_price * item_quantity) as item_gross_amount,
        (item_list_price * item_discount * item_quantity) as item_discount_amount,
        ((item_list_price * item_quantity) - (item_list_price * item_discount * item_quantity)) as item_net_amount
    from {{ ref('stg_sales__order_items') }}
)

select
    oi.order_item_id,
    o.order_id,
    oi.item_id,
    o.store_id,
    o.customer_id,
    o.staff_id,
    o.order_created_at,
    o.order_estimated_delivery_date,
    o.order_shipped_at,
    oi.product_id,
    ca.item_gross_amount,
    ca.item_discount_amount,
    ca.item_net_amount
from {{ ref('stg_sales__orders') }} as o
inner join {{ ref('stg_sales__order_items') }} as oi
    on o.order_id = oi.order_id
inner join calculation_of_amounts as ca
    on oi.order_item_id = ca.order_item_id
order by order_item_id