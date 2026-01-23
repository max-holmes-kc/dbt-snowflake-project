with source as (
    select * from {{ source('raw', 'circles_policies') }}
),

renamed as (
    select
        {{ generate_policy_aliases('circles') }},
        'circles' as source_system
    from source
)

select * from renamed
