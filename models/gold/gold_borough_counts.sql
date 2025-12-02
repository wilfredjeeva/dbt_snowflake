select
  borough_name,
  count(*) as row_count
from {{ ref('silver_boroughs') }}
group by 1
order by 2 desc
