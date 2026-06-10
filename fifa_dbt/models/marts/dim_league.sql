select
    l.league_id,
    l.league_name,
    c.country_name
from {{ ref('stg_league') }} l
left join {{ ref('stg_country') }} c
    on l.country_id = c.country_id
