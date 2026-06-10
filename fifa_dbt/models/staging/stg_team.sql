select
    team_api_id,
    team_long_name,
    team_short_name
from {{ source('fifa_silver', 'silver_team') }}
