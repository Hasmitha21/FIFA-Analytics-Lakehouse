
  
  
  
  create or replace view `workspace`.`fifa_project_dbt`.`stg_country`
  
  as (
    select
    country_id,
    country_name
from `workspace`.`fifa_project`.`silver_country`
  )
