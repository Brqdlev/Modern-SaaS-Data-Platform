{{ config(materialized='view') }}

select
    subscription_id,
    account_id,
    lower(trim(plan_name)) as plan_name,
    monthly_price,
    lower(trim(subscription_status)) as subscription_status,
    start_date,
    end_date,
    CAST(created_at as timestamp) as created_at,
    CASt(updated_at as timestamp) as updated_at,
    _airbyte_extracted_at,
    _airbyte_generation_id
from {{ source('bronze', 'subscriptions')}}