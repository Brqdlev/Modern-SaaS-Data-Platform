{{ config(
    materialized='incremental',
    unique_key='event_id'
) }}


select
    event_id,
    incident_id,
    event_type,
    event_time,
    _airbyte_extracted_at
from {{ ref('incident_events_silver') }}

{% if is_incremental() %}
where _airbyte_extracted_at > (select max(_airbyte_extracted_at) from {{ this }})
{% endif %}