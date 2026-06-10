
  
    
        create or replace table `workspace`.`fifa_project_dbt`.`dim_team`
      
      
    using delta
  
      
      
      
      
      
      
      
      
      as
      select * from `workspace`.`fifa_project_dbt`.`stg_team`
  