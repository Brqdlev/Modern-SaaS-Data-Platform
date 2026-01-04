with ranked as (
    select
        subscription_id,
        account_id,
        plan_name,
        monthly_price,
        subscription_status,
        start_date,
        end_date,
        created_at,
        updated_at,
        _airbyte_extracted_at,
        _airbyte_generation_id,

        row_number() over (
            partition by subscription_id
            order by _airbyte_extracted_at desc
        ) as rn
    from {{ ref('stg_subscriptions') }}
)

select
    subscription_id,
    account_id,
    plan_name,
    monthly_price,
    subscription_status,
    start_date,
    end_date,
    created_at,
    updated_at,
    _airbyte_extracted_at,
    _airbyte_generation_id
from ranked
where rn = 1