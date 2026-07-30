with hosts AS
(
    select
        host_id,
        host_name,
        host_since,
        is_superhost,
        response_category,
        host_created_at
    from
        {{ ref("OBT") }}
)
select
    *
from
    hosts