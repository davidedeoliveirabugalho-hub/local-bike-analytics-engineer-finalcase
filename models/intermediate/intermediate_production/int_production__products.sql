with product_categories as (

    select
        p.product_id as product_id,
        c.category_name as category_name
    from {{ ref('stg_production__products') }} as p
    left join {{ ref('stg_production__categories') }} as c
        on p.product_category_id = c.category_id
),

product_brands as (

    select
       p.product_id as product_id,
        b.brand_name as brand_name
    from {{ ref('stg_production__products') }} as p
    left join {{ ref('stg_production__brands') }} as b
        on p.product_brand_id = b.brand_id
)

select
    p.product_id as product_id,
    p.product_name as product_name,
    p.product_model_year as product_model_year,
    p.product_list_price as product_list_price,
    c.category_name as product_category_name,
    b.brand_name as product_brand_name
from {{ ref('stg_production__products') }} as p
left join product_categories as c
    on p.product_id = c.product_id
left join product_brands as b
    on p.product_id = b.product_id
order by p.product_id