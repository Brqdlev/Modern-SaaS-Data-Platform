with ranked as (
    select
        incident_id,
        account_id,
        incident_type,
        severity,
        incident_status,
        created_at,
        updated_at,
        _airbyte_extracted_at,
        _airbyte_generation_id,

        row_number() over (
            partition by incident_id
            order by _airbyte_extracted_at desc
        ) as rn

    from {{ ref('stg_incidents' )}}
)

select
    incident_id,
    account_id,
    incident_type,
    severity,
    incident_status,
    created_at,
    updated_at,
    _airbyte_extracted_at,
    _airbyte_generation_id
from ranked
where rn = 1