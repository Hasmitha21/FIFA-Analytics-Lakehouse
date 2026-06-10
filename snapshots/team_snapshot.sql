{% snapshot team_snapshot %}

{{
    config(
      target_schema='fifa_project_dbt_snapshots',
      unique_key='team_api_id',
      strategy='check',
      check_cols=['team_long_name', 'team_short_name'],
    )
}}

select * from {{ source('fifa_silver', 'silver_team') }}

{% endsnapshot %}
