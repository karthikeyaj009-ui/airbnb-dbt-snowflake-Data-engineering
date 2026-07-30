{% macro mul(a,b,decimal)%}
    round({{ a }} * {{ b }}, {{ decimal }})
{% endmacro %}