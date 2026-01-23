{% macro generate_policy_aliases(source_system) %}
    {#- 
        Generates column aliases based on policy_mapping var in dbt_project.yml.
        Args:
            source_system: 'circles' or 's_insurance'
    -#}
    
    {%- set source_column = source_system ~ '_column_name' -%}
    {%- set mapping_data = var('policy_mapping') -%}
    
    {%- set column_list = [] -%}
    {%- for row in mapping_data -%}
        {%- set src_col = row[source_column] -%}
        {%- if src_col and src_col | trim != '' -%}
            {%- set data_type = row['data_type'] -%}
            {%- set _ = column_list.append('cast(' ~ src_col ~ ' as ' ~ data_type ~ ') as ' ~ row['target_column_name']) -%}
        {%- endif -%}
    {%- endfor -%}
    {{ column_list | join(',\n        ') }}
{% endmacro %}
