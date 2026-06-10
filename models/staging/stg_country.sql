select
    country_id,
    country_name
from {{ source('fifa_silver', 'silver_country') }}
