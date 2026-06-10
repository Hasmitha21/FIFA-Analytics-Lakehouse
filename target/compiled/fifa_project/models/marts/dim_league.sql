select
    l.league_id,
    l.league_name,
    c.country_name
from `workspace`.`fifa_project_dbt`.`stg_league` l
left join `workspace`.`fifa_project_dbt`.`stg_country` c
    on l.country_id = c.country_id