{{ config(
    materialized = 'table'
) }}

with date_range as(

    select 
        date_range_unnest
    from unnest(GENERATE_DATE_ARRAY (
                (select min(order_created_at) 
                    from {{ ref('int_sales__orders') }}), 
                (select max(order_created_at) 
                    from {{ ref('int_sales__orders') }})
                                        )
                    ) as date_range_unnest
)

select
    date_range_unnest as calendar_date,
    extract(year from date_range_unnest) as calendar_year,
    extract(month from date_range_unnest) as calendar_month,
    extract(day from date_range_unnest) as calendar_day,
    extract(week from date_range_unnest) as calendar_week_number,
    extract(dayofweek from date_range_unnest) as calendar_day_of_week,
    case when extract(dayofweek from date_range_unnest) in (1, 7) then true
        else false
    end as is_weekend
from date_range
order by calendar_date