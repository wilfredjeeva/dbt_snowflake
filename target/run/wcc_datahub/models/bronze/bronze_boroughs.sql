
  
    

create or replace transient table ANALYTICS_DEV.SILVER_BRONZE.bronze_boroughs
    

    
    as (-- Bronze: lightly curated from the seed
select
  cast(borough_id as number) as borough_id,
  cast(name as string)       as name
from ANALYTICS_DEV.SILVER_LANDING.boroughs
    )
;


  