{{
    config(materialized='incremental', unique_key='host_id')
}}

select
    host_id,
    replace(host_name, ' ', '_') as host_name,
    host_since,
    is_superhost,
    response_rate as Response_Rate,
    case
        when response_rate > 100 then 'very Good'
        when response_rate > 80 then 'Good'
        else 'Poor'
    end as Response_Category,
    created_At
from {{ ref('raw_hosts') }}