{{ config(
    materialized='incremental',
    unique_key='event_id'
)}}


select
    event_id,
    user_id,
    login_time,
    ip_address,
    _airbyte_extracted_at
from {{ ref('login_events_silver') }}

{% if is_incremental %}
where _airbyte_extracted_at > (select max(_airbyte_extracted_at) from {{ this }})
{% endif %}

