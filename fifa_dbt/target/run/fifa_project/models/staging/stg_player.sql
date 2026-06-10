
  
  
  
  create or replace view `workspace`.`fifa_project_dbt`.`stg_player`
  
  as (
    select
    player_api_id,
    player_name,
    birthday,
    height,
    weight
from `workspace`.`fifa_project`.`silver_player`
  )
