
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select borough_id
from ANALYTICS_DEV.SILVER_SILVER.silver_boroughs
where borough_id is null



  
  
      
    ) dbt_internal_test