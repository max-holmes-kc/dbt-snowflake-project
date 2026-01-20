with source as (
    select * from {{ source('raw', 'orders') }}
),

staged as (
    select
        id as order_id,
        customer_id,
        order_date,
        status,
        amount_cents / 100.0 as amount,
        created_at,
        updated_at
    from source
)

select * from staged
