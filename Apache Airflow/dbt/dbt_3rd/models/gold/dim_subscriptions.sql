select
    subscription_id,
    account_id,
    plan_name,
    monthly_price,
    subscription_status,
    start_date,
    end_date,
    created_at,
    updated_at
from {{ ref('subscriptions_silver') }}