with circles_policies as (
    select * from {{ ref('stg_circles_policies') }}
),

s_insurance_policies as (
    select * from {{ ref('stg_s_insurance_policies') }}
),

final as (
    select
        *
    from circles_policies
    union by name
    select
        *
    from s_insurance_policies
)

select * from final
