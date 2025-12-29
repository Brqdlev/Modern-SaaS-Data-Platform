select
    account_id,
    account_name,
    account_status,
    created_at,
    updated_at
from {{ ref('accounts_silver') }}