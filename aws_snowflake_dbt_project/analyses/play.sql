{% set nights_booked = 5 %}

select
    *
from
    {{ ref('raw_booking') }}
where
    nights_booked > {{ nights_booked }}