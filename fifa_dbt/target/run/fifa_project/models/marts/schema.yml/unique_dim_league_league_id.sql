
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    league_id as unique_field,
    count(*) as n_records

from `workspace`.`fifa_project_dbt`.`dim_league`
where league_id is not null
group by league_id
having count(*) > 1



  
  
      
    ) dbt_internal_test