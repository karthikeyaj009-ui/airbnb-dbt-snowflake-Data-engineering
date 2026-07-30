{% set list = [ 'booking_id','nights_booked' ,'booking_amount'] %}
{% set flag = 1%}

{% if flag == 1 %}

   select
      {% for i in list %}
         {{ i }}
         {% if not loop.first %}, {% endif %}
      {% endfor %}
   from
      {{ ref('raw_booking') }}

{%else%}
   select
      {% for i in list %}
         {{ i }}
         {% if not loop.last %}, {% endif %}
      {% endfor %}
   from
      {{ ref('raw_booking') }}
{%endif%}


