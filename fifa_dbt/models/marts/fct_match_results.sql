with match as (
    select * from {{ ref('stg_match') }}
),

home_team as (
    select
        team_api_id as home_team_api_id,
        team_long_name as home_team_name
    from {{ ref('stg_team') }}
),

away_team as (
    select
        team_api_id as away_team_api_id,
        team_long_name as away_team_name
    from {{ ref('stg_team') }}
)

select
    m.match_api_id,
    m.league_id,
    m.season,
    m.stage,
    m.date,
    m.home_team_api_id,
    ht.home_team_name,
    m.away_team_api_id,
    at.away_team_name,
    m.home_team_goal,
    m.away_team_goal,
    case
        when m.home_team_goal > m.away_team_goal then 'HOME_WIN'
        when m.home_team_goal < m.away_team_goal then 'AWAY_WIN'
        else 'DRAW'
    end as result,
    abs(m.home_team_goal - m.away_team_goal) as goal_difference
from match m
left join home_team ht on m.home_team_api_id = ht.home_team_api_id
left join away_team at on m.away_team_api_id = at.away_team_api_id
