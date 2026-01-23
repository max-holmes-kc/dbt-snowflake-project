{% macro generate_fact_policy_columns() %}
    {#- 
        Generates column definitions for fact_policy model from policy_mapping.csv.
        Reads CSV directly at parse time (no database connection needed).
    -#}
    {%- set csv_content = load_file_contents('seeds/policy_mapping.csv') -%}
    {%- set lines = csv_content.strip().split('\n') -%}
    
    {%- for line in lines[1:] if line.strip() -%}
        {%- set values = line.split(',') -%}
        {%- set target_name = values[0].strip() -%}
        {%- set target_desc = values[1].strip() if values | length > 1 else '' -%}
        {%- if target_name %}
      - name: {{ target_name }}
        description: "{{ target_desc }}"
        {%- endif %}
    {%- endfor -%}
{% endmacro %}
