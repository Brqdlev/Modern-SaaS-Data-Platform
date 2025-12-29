select
    user_id,
    account_id,
    email,
    role,
    is_active,
    created_at,
    updated_at
from {{ ref('users_silver') }}