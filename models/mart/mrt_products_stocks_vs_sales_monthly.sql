with monthly_sales as (
    select
        product_id,
        store_id,
        date_trunc(order_created_at, month) as sale_month,
        sum(item_quantity) as monthly_qty_sold,
        sum(item_net_amount) as monthly_revenue
    from {{ ref('int_sales__orders') }}
    group by 
        product_id, 
        store_id, 
        sale_month
),

avg_monthly_sales as (
    select
        product_id,
        store_id,
        avg(monthly_qty_sold) as avg_monthly_qty,
        avg(monthly_revenue) as avg_monthly_revenue,
        count(*) as nb_months_sold
    from monthly_sales
    group by 
        product_id, 
        store_id
),

latest_stocks as (
    select
        product_id,
        store_id,
        stock_quantity
    from {{ ref('stg_production__stocks') }}
)

select
    p.product_id as product_id,
    ls.store_id as store_id,
    p.product_name as product_name,
    p.product_category_name as product_category_name,
    p.product_brand_name as product_brand_name,
    ls.stock_quantity as stock_quantity,
    ams.avg_monthly_qty as avg_monthly_qty,
    ams.avg_monthly_revenue as avg_monthly_revenue,
    ams.nb_months_sold as nb_months_sold,
    ls.stock_quantity / (ams.avg_monthly_qty / 30) as day_of_coverage,
    ams.avg_monthly_qty / nullif(ls.stock_quantity, 0) as rotation_ratio,
    case 
        when (ams.avg_monthly_qty / nullif(ls.stock_quantity, 0)) < 0.8 then 'overstock'
        when (ams.avg_monthly_qty / nullif(ls.stock_quantity, 0)) > 1.2 then 'understock'
        when ls.stock_quantity = 0 and ams.avg_monthly_qty > 0 then 'rupture'
        else 'normal'
    end as stock_status
from latest_stocks ls
left join avg_monthly_sales ams
    on ls.product_id = ams.product_id
    and ls.store_id = ams.store_id
left join {{ ref('int_production__products') }} p
    on ls.product_id = p.product_id
group by
    p.product_id,
    ls.store_id,
    p.product_name,
    p.product_category_name,
    p.product_brand_name,
    ls.stock_quantity,
    ams.avg_monthly_qty,
    ams.avg_monthly_revenue,
    ams.nb_months_sold
order by
    p.product_id,
    ls.store_id