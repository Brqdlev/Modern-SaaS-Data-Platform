with base as (
    select
        date(event_time) as event_date,
        account_id,
        usage_count,
        event_time
    from {{ ref('usage_events_silver') }}
)

select
    event_date,

    --- volume ---
    sum(usage_count) as total_usage_count,

    --- distribution per acc ---
    count(distinct account_id) as active_accounts,
    sum(usage_count) / nullif(count(distinct account_id), 0) as usage_per_account,

    --- freshness of data ---
    max(event_time) as last_event_time,

    -- trends ---
    lag(sum(usage_count)) over (order by event_date) as prev_day_usage,

    avg(sum(usage_count)) over (
        order by event_date
        rows between 6 preceding and current row
    ) as avg_7d_usage


from base 
group by event_date
order by event_date