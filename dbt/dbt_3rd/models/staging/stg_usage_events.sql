select
    event_id,
    account_id,
    lower(trim(feature_name)) as feature_name,
    usage_count,
    CAST(event_time as timestamp) as event_time,
    _airbyte_extracted_at,
    _airbyte_generation_id
from {{ source('bronze', 'usage_events')}}