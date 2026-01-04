with ranked as (
    select
        user_id,
        account_id,
        email,
        role,
        is_active,
        created_at,
        updated_at,
        _airbyte_extracted_at,
        _airbyte_generation_id,

        row_number() over (
            partition by user_id
            order by _airbyte_extracted_at desc
        ) as rn
    from {{ ref('stg_users') }}

)

select
    user_id,
    account_id,
    email,
    role,
    is_active,
    created_at,
    updated_at,
    _airbyte_extracted_at,
    _airbyte_generation_id
from ranked
where rn = 1