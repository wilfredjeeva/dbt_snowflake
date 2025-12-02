{#
    This macro overrides dbt's default schema naming behavior.
    Instead of prepending the target schema (from profiles.yml) to custom schemas,
    it uses ONLY the custom schema name specified in dbt_project.yml.
    
    For example:
    - Without this macro: SILVER_BRONZE, SILVER_GOLD, etc.
    - With this macro: BRONZE, GOLD, etc.
#}

{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
