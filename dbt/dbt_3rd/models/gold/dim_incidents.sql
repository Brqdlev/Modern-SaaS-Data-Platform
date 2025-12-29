select
    incident_id,
    account_id,
    incident_type,
    severity,
    incident_status,
    created_at,
    updated_at
from {{ ref('incidents_silver') }}