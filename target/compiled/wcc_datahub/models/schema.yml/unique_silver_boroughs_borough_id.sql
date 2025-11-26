
    
    

select
    borough_id as unique_field,
    count(*) as n_records

from ANALYTICS_DEV.SILVER_SILVER.silver_boroughs
where borough_id is not null
group by borough_id
having count(*) > 1


