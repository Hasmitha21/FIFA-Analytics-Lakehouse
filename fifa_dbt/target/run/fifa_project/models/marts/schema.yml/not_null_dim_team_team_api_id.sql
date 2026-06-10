
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select team_api_id
from `workspace`.`fifa_project_dbt`.`dim_team`
where team_api_id is null



  
  
      
    ) dbt_internal_test