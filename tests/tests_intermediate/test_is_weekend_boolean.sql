select *
from {{ ref('int_dates') }}
where is_weekend not in (true, false)