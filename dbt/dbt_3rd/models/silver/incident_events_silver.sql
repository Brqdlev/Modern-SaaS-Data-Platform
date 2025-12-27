select
    event_id,
    incident_id,
    event_type,
    event_time,
    _airbyte_extracted_at,
    _airbyte_generation_id
from {{ ref('stg_incident_events') }}