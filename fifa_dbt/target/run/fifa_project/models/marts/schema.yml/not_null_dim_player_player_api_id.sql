
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select player_api_id
from `workspace`.`fifa_project_dbt`.`dim_player`
where player_api_id is null



  
  
      
    ) dbt_internal_test