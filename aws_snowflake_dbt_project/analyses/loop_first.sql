{% set list = ['booking_id','nights_booked','booking_amount'] %}

select
     {% for i in list %}
        {{ i }}
        {% if not loop.first %}, {% endif %}
     {% endfor %}
from
    {{ ref('raw_booking') }}

 