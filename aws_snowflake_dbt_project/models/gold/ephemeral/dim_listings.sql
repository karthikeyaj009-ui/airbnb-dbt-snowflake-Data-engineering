with listings AS
(
    select 
        listing_id,
        property_Type,
        room_type,
        city,
        country,
        price_tag,
        listing_created_at
    from 
        {{ ref("OBT") }}
)
select 
    *
from
    listings