{{ config(materialized='view') }}

select
    user_id::bigint as user_id,
    account_id::bigint as account_id,
    lower(trim(email)) as email,
    lower(trim(role)) as role,
    is_active,
    CAST(created_at as timestamp) as created_at,
    CAST(updated_at as timestamp) as updated_at,
    _airbyte_extracted_at,
    _airbyte_generation_id
from {{ source('bronze', 'users')}}