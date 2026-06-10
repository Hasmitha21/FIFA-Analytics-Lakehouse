
  
    
        create or replace table `workspace`.`fifa_project_dbt`.`dim_player`
      
      
    using delta
  
      
      
      
      
      
      
      
      
      as
      select * from `workspace`.`fifa_project_dbt`.`stg_player`
  