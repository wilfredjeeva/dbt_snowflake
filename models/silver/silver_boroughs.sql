
-- Silver: cleaned & incremental
{{ config(
    materialized='incremental',
    unique_key='borough_id',
    on_schema_change='sync_all_columns'
) }}

select
  borough_id,
  initcap(name) as borough_name
from {{ ref('bronze_boroughs') }}

{% if is_incremental() %}
where borough_id not in (select borough_id from {{ this }})
{% endif %}
