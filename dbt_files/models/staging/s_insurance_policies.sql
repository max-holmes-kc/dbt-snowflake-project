with source as (
    select * from {{ source('raw', 's_insurance_policies') }}
),

renamed as (
    select
        {{ generate_policy_aliases('s_insurance') }},
        "s_insurance" as source_system
    from source
    
)

select * from renamed
