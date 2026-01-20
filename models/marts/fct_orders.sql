with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

final as (
    select
        o.order_id,
        o.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        o.order_date,
        o.status,
        o.amount,
        o.created_at,
        o.updated_at
    from orders o
    left join customers c on o.customer_id = c.customer_id
)

select * from final
