with circles_policies as (
    select * from {{ ref('circles_policies') }}
),

s_insurance_policies as (
    select * from {{ ref('s_insurance_policies') }}
),

final as (
    select
        *
    from circles_policies
    union by name all
    select
        *
    from s_insurance_policies
)

select * from final
