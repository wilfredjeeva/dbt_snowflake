
-- Bronze: lightly curated from the seed
select
  cast(borough_id as number) as borough_id,
  cast(name as string)       as name
from {{ ref('boroughs') }}
