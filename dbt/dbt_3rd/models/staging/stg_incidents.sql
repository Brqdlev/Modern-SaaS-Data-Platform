{{ config(materialized='view') }}

select
    incident_id::bigint as incident_id,
    account_id::bigint as account_id,
    lower(trim(incident_type)) as incident_type,
    lower(trim(severity)) as severity,
    lower(trim(incident_status)) as incident_status,
    CAST(created_at as timestamp) as created_at,
    CAST(updated_at as timestamp) as updated_at,
    _airbyte_extracted_at,
    _airbyte_generation_id
from {{ source('bronze', 'incidents')}}