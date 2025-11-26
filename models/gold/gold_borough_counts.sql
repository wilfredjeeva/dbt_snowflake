
-- Gold: tiny aggregate to prove lineage
select count(*) as row_count
from {{ ref('silver_boroughs') }}
