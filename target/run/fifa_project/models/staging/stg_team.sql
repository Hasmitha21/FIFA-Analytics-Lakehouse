
  
  
  
  create or replace view `workspace`.`fifa_project_dbt`.`stg_team`
  
  as (
    select
    team_api_id,
    team_long_name,
    team_short_name
from `workspace`.`fifa_project`.`silver_team`
  )
