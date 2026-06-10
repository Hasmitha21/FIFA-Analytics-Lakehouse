select
    match_api_id,
    country_id,
    league_id,
    season,
    stage,
    date,
    home_team_api_id,
    away_team_api_id,
    home_team_goal,
    away_team_goal
from {{ source('fifa_silver', 'silver_match') }}
