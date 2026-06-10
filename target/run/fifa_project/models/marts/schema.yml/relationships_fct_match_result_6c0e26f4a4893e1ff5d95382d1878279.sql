
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select home_team_api_id as from_field
    from `workspace`.`fifa_project_dbt`.`fct_match_results`
    where home_team_api_id is not null
),

parent as (
    select team_api_id as to_field
    from `workspace`.`fifa_project_dbt`.`dim_team`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test