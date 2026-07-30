{%
    set tables_list = [
        {
            "table_name" : "AIRBNB.SILVER.SILVER_BOOKINGS",
            "column_names" : "silver_bookings.*",
            "alias" : "silver_bookings"
        },
        {
            "table_name" : "AIRBNB.SILVER.SILVER_LISTINGS",
            "column_names" : "silver_listings.property_type, silver_listings.room_type, silver_listings.city, silver_listings.country, silver_listings.Accommodates,silver_listings.bedrooms, silver_listings.price_per_night, silver_listings.price_tag, silver_listings.created_at as listing_created_at",
            "alias" : "silver_listings",
            "join_condition" : "silver_bookings.listing_id = silver_listings.listing_id"
        },
        {
            "table_name" : "AIRBNB.SILVER.SILVER_HOSTS",
            "column_names" : "silver_hosts.host_id, silver_hosts.host_name, silver_hosts.host_since, silver_hosts.is_superhost, silver_hosts.Response_Rate, silver_hosts.Response_Category, silver_hosts.created_At as host_created_at",
            "alias" : "silver_hosts",
            "join_condition" : "silver_listings.host_id = silver_hosts.host_id"
        }
        
    ]
%}

select
    {% for i in tables_list %}
       {{ i['column_names']}}  {% if not loop.last %}, {% endif %}
        
    {% endfor %}
from
{% for i in tables_list %}
    {% if loop.first %}
        {{ i['table_name'] }} AS {{ i['alias'] }}
    {% else %}
        LEFT JOIN {{ i['table_name'] }} AS {{ i['alias'] }}
        ON {{ i['join_condition'] }}
    {% endif %}
{% endfor %}
