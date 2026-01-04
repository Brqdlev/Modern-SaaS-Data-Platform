
select
    event_id::bigint as event_id,
    user_id::bigint as user_id,
    CAST(login_time as timestamp) as login_time,
    ip_address,
    _airbyte_extracted_at,
    _airbyte_generation_id
from {{ source('bronze', 'login_events')}}