{% set flag = 0 %}

select
    *
from
    {{ ref('raw_booking') }}

{% if flag == 1 %}
    where nights_booked > 1
{% else %}
    where nights_booked = 1
{% endif %}