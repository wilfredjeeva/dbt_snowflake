select
  borough_id,
  borough_name
from {{ ref('bronze_boroughs') }}
