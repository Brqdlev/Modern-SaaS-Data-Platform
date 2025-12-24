{{ config(materialized='view') }}

select
    event_id::bigint as event_id,
    incident_id::bigint as incident_id,
    lower(
        trim(
            replace(
                replace(event_type, '_', ' '),
                '-', ' '
            )
        )
    ),
    CAST(event_time as timestamp) as event_time,
    _airbyte_extracted_at,
    _airbyte_generation_id
from {{ source('bronze', 'incident_events')}}