{% macro generate_policy_aliases(source_system) %}
    {#- 
        Generates column aliases based on policy_mapping seed table.
        Args:
            source_system: 'circles' or 's_insurance'
    -#}
    
    {%- set source_column = source_system ~ '_column_name' -%}
    
    {%- set mapping_query -%}
        select 
            target_column_name,
            {{ source_column }} as source_column_name
        from {{ source('raw', 'policy_mapping') }}
        where {{ source_column }} is not null 
          and trim({{ source_column }}) != ''
    {%- endset -%}
    
    {%- set results = run_query(mapping_query) -%}
    
    {%- if execute -%}
        {%- set column_list = [] -%}
        {%- for row in results -%}
            {%- set _ = column_list.append(row['SOURCE_COLUMN_NAME'] ~ ' as ' ~ row['TARGET_COLUMN_NAME']) -%}
        {%- endfor -%}
        {{ column_list | join(',\n        ') }}
    {%- endif -%}
{% endmacro %}
