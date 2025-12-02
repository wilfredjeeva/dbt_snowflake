-- from seeds -> LANDING
select
  cast(borough_id as int) as borough_id,
  initcap(borough_name)   as borough_name,
  current_timestamp()     as ingested_at
from {{ ref('boroughs') }}
