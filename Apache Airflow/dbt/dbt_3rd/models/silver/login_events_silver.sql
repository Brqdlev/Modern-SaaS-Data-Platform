select
    event_id,
    user_id,
    login_time,
    ip_address,
    _airbyte_extracted_at,
    _airbyte_generation_id
from {{ ref('stg_login_events') }}