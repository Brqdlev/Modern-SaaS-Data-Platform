
select
    event_id,
    account_id,
    lower(trim(event_type)) as event_type,
    event_amount,
    CAST(event_time as timestamp) as event_time,
    _airbyte_extracted_at,
    _airbyte_generation_id
from {{ source('bronze', 'billing_events')}}