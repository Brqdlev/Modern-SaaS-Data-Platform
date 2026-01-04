from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

DBT_DIR = "/opt/dbt/dbt_3rd"

with DAG(
    dag_id="dbt_bronze_to_gold",
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=["dbt", "analytics"],
) as dag:

    dbt_staging = BashOperator(
        task_id="dbt_staging",
        bash_command=f"cd {DBT_DIR} && dbt run --select staging",
    )

    dbt_test_staging = BashOperator(
        task_id="dbt_test_staging",
        bash_command=f"cd {DBT_DIR} && dbt test --select staging",
    )

    dbt_silver = BashOperator(
        task_id="dbt_silver",
        bash_command=f"cd {DBT_DIR} && dbt run --select silver",
    )

    dbt_gold = BashOperator(
        task_id="dbt_gold",
        bash_command=f"cd {DBT_DIR} && dbt run --select gold",
    )

    dbt_anomaly = BashOperator(
        task_id = "dbt_anomaly",
        bash_command=f"cd {DBT_DIR} && dbt run --select ai "
    )

    dbt_staging >> dbt_test_staging >> dbt_silver >> dbt_anomaly >> dbt_gold
