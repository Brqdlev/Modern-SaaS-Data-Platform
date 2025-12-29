{{ config(
    materialized='incremental',
    unique_key='event_id'
)}}

select  
    event_id,
    account_id,
    feature_name,
    usage_count,
    event_time,
    _airbyte_extracted_at
from {{ ref('usage_events_silver') }}


{% if is_incremental %}
where _airbyte_extracted_at > (select max(_airbyte_extracted_at) from {{ this }})
{% endif %}