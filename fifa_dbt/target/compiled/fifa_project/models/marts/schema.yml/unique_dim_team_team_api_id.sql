
    
    

select
    team_api_id as unique_field,
    count(*) as n_records

from `workspace`.`fifa_project_dbt`.`dim_team`
where team_api_id is not null
group by team_api_id
having count(*) > 1


