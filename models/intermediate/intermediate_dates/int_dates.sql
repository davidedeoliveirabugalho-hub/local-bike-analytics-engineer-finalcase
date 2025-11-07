{{ config(
    materialized = 'table'
) }}

with date_range as(

    select 
        date_range_unnest
    from unnest(GENERATE_DATE_ARRAY (
                (select min(order_created_at) 
                    from {{ ref('stg_sales__orders') }}), 
                (select max(order_created_at) 
                    from {{ ref('stg_sales__orders') }})
                                        )
                    ) as date_range_unnest
)

select
    date_range_unnest as calendar_date,
    date_trunc(date_range_unnest, year) as calendar_year,
    date_trunc(date_range_unnest, month) as calendar_month,
    date_trunc(date_range_unnest, day) as calendar_day,
    date_trunc(date_range_unnest, week) as calendar_week_number,
    extract(dayofweek from date_range_unnest) as calendar_day_of_week,
    case when extract(dayofweek from date_range_unnest) in (1, 7) then true
        else false
    end as is_weekend
from date_range
order by calendar_date