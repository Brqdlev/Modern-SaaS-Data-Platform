select
    event_id,
    account_id,
    feature_name,
    usage_count,
    event_time,
    _airbyte_extracted_at,
    _airbyte_generation_id
from {{ ref('stg_usage_events') }}