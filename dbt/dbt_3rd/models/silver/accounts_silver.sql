
with ranked as (
    select
        account_id,
        account_name,
        account_status,
        created_at,
        updated_at,
        _airbyte_extracted_at,
        _airbyte_generation_id,

        row_number() over (
            partition by account_id
            order by _airbyte_extracted_at desc
        ) as rn
    
    from {{ ref('stg_accounts') }}

)

select
    account_id,
    account_name,
    account_status,
    created_at,
    updated_at,
    _airbyte_extracted_at,
    _airbyte_generation_id
from ranked
where rn = 1