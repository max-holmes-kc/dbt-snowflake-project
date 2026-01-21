with source as (
    select * from {{ source('raw', 'customers') }}
),

staged as (
    select
        id as customer_id,
        trim(first_name) as first_name,
        trim(last_name) as last_name,
        lower(trim(email)) as email,
        created_at,
        updated_at
    from source
)

select * from staged
