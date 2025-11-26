
  
    

create or replace transient table ANALYTICS_DEV.SILVER_SILVER.silver_boroughs
    

    
    as (-- Silver: cleaned & incremental


select
  borough_id,
  initcap(name) as borough_name
from ANALYTICS_DEV.SILVER_BRONZE.bronze_boroughs


    )
;


  