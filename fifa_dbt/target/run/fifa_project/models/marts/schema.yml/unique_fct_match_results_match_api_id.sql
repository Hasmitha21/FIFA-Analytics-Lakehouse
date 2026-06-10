
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    match_api_id as unique_field,
    count(*) as n_records

from `workspace`.`fifa_project_dbt`.`fct_match_results`
where match_api_id is not null
group by match_api_id
having count(*) > 1



  
  
      
    ) dbt_internal_test