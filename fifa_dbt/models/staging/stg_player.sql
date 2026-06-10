select
    player_api_id,
    player_name,
    birthday,
    height,
    weight
from {{ source('fifa_silver', 'silver_player') }}
