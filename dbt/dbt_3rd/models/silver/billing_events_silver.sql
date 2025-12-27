select
    event_id,
    account_id,
    event_type,
    event_amount,
    event_time,
    _airbyte_extracted_at,
    _airbyte_generation_id
from {{ ref('stg_billing_events') }}