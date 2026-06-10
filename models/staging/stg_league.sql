select
    league_id,
    country_id,
    league_name
from {{ source('fifa_silver', 'silver_league') }}
