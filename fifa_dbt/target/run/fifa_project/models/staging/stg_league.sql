
  
  
  
  create or replace view `workspace`.`fifa_project_dbt`.`stg_league`
  
  as (
    select
    league_id,
    country_id,
    league_name
from `workspace`.`fifa_project`.`silver_league`
  )
