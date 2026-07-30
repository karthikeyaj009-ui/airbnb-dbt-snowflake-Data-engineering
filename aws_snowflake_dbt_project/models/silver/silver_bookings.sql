{{ 
    config(materialized='incremental', 
    unique_key='booking_id' 
    )
}}

select 
    booking_id,
    listing_id,
    booking_date,
    {{ mul('nights_booked', 'booking_amount', 2) }} + cleaning_fee + service_fee as total_amount,
    booking_status,
    created_at
from
    {{ ref('raw_booking') }}
