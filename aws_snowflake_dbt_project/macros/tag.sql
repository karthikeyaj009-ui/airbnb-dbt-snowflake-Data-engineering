{% macro tag(col_name) %}
    case
        when {{ col_name }} > 100 then 'high_value'
        when {{ col_name }} > 50 then 'medium_value'
        else 'low_value'
    end
{% endmacro %}