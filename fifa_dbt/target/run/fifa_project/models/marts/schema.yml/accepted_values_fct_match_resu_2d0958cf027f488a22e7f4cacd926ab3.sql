
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        result as value_field,
        count(*) as n_records

    from `workspace`.`fifa_project_dbt`.`fct_match_results`
    group by result

)

select *
from all_values
where value_field not in (
    'HOME_WIN','AWAY_WIN','DRAW'
)



  
  
      
    ) dbt_internal_test