
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    player_api_id as unique_field,
    count(*) as n_records

from `workspace`.`fifa_project_dbt`.`dim_player`
where player_api_id is not null
group by player_api_id
having count(*) > 1



  
  
      
    ) dbt_internal_test