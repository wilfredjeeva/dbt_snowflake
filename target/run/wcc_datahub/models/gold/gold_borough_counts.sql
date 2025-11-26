
  
    

create or replace transient table ANALYTICS_DEV.SILVER_GOLD.gold_borough_counts
    

    
    as (-- Gold: tiny aggregate to prove lineage
select count(*) as row_count
from ANALYTICS_DEV.SILVER_SILVER.silver_boroughs
    )
;


  