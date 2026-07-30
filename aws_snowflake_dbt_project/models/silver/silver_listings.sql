{{ 
    config(materialized='incremental', 
    unique_key='listing_id' 
    )
}}

select
    listing_id,
    host_id,
    property_type,
    {{ trim('room_type') }} as Room_Type,
    city,
    country,
    Accommodates,
    bedrooms,
    bathrooms,
    price_per_night,
    {{ tag("cast(price_per_night as int)") }} as Price_Tag,
    created_at

from
    {{ ref('raw_listings') }}