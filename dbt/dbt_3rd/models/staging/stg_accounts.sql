{{ config(materialized='view') }}

select
    account_id, 
    lower(
        trim(
            replace(
                replace(account_name, '_', ' '),
            '-', ' ')
        )
    ) as account_name,
    lower(trim(account_status)) as account_status,
    CAST(created_at as timestamp) as created_at, 
    CAST(updated_at as timestamp) as updated_at,
    _airbyte_extracted_at,
    _airbyte_generation_id
from {{ source('bronze', 'accounts')}}
