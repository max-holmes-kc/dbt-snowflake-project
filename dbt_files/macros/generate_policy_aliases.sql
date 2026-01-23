{% macro generate_policy_aliases(source_system) %}
    {#- 
        Generates column aliases based on policy_mapping.yml file.
        Args:
            source_system: 'circles' or 's_insurance'
    -#}
    
    {%- set source_column = source_system ~ '_column_name' -%}
    
    {%- set yaml_content -%}
        {% include 'policy_mapping.yml' %}
    {%- endset -%}
    {%- set mapping_data = fromyaml(yaml_content) -%}
    
    {%- set column_list = [] -%}
    {%- for row in mapping_data['policy_mapping'] -%}
        {%- set src_col = row[source_column] -%}
        {%- if src_col and src_col | trim != '' -%}
            {%- set _ = column_list.append(src_col ~ ' as ' ~ row['target_column_name']) -%}
        {%- endif -%}
    {%- endfor -%}
    {{ column_list | join(',\n        ') }}
{% endmacro %}
