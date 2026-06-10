
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select league_id
from `workspace`.`fifa_project_dbt`.`dim_league`
where league_id is null



  
  
      
    ) dbt_internal_test