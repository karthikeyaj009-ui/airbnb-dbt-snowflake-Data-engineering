{%
    set tables_list = [
        {
            "name" : "AIRBNB.GOLD.OBT",
            "columns" : " gold_obt.booking_id, gold_obt.host_id, gold_obt.listing_id,gold_obt.total_amount as total_amount_guest_paid, gold_obt.accommodates, gold_obt.bedrooms, gold_obt.price_per_night,gold_obt.response_rate ",
            "alias" : "gold_obt"
        },
        {
            "name" : "AIRBNB.GOLD.listings",
            "columns" : "",
            "alias" : "gold_listings",
            "join_condition" : "gold_obt.listing_id = gold_listings.listing_id"
        },
        {
            "name" : "AIRBNB.GOLD.hosts",
            "columns" : "",
            "alias" : "gold_hosts", 
            "join_condition" : "gold_obt.host_id = gold_hosts.host_id"
        }
    ]
%}

select
    {{ tables_list[0].columns }}
from
    {% for table in tables_list %}
        {% if loop.first %}
            {{ table.name }} {{ table.alias }}
        {% else %}
            join {{ table.name }} {{ table.alias }} on {{ table.join_condition }}
        {% endif %}
    {% endfor %}
