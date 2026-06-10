
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select match_api_id
from `workspace`.`fifa_project_dbt`.`fct_match_results`
where match_api_id is null



  
  
      
    ) dbt_internal_test