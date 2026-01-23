{% macro generate_fact_policy_columns() %}
    {#- 
        Generates column definitions for fact_policy model from policy_mapping seed.
        Returns YAML-formatted column definitions with descriptions.
    -#}
    
    {%- set mapping_query -%}
        select 
            target_column_name,
            target_column_description
        from {{ ref('policy_mapping') }}
        where target_column_name is not null 
          and trim(target_column_name) != ''
    {%- endset -%}
    
    {%- set results = run_query(mapping_query) -%}
    
    {%- if execute -%}
        {%- for row in results %}
      - name: {{ row['TARGET_COLUMN_NAME'] }}
        description: "{{ row['TARGET_COLUMN_DESCRIPTION'] }}"
        {%- endfor %}
    {%- endif -%}
{% endmacro %}
