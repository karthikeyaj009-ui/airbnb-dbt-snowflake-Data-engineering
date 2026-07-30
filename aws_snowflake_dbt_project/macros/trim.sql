{% macro trim(col_name) %}
    upper(trim({{ col_name }}))
{% endmacro %}