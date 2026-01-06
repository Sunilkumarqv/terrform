import os
import snowflake.connector

# Connection parameters
account = os.getenv("SNOWFLAKE_ACCOUNT")
user = os.getenv("SNOWFLAKE_USER")
password = os.getenv("SNOWFLAKE_PASSWORD")
role = os.getenv("SNOWFLAKE_ROLE") or "PUBLIC"
warehouse = os.getenv("SNOWFLAKE_WAREHOUSE")
database = os.getenv("SNOWFLAKE_DATABASE")
schema = os.getenv("SNOWFLAKE_SCHEMA")

ctx = snowflake.connector.connect(
    user=user,
    password=password,
    account=account,
    role=role,
    warehouse=warehouse,
    database=database,
    schema=schema
)

print("Connected successfully.")

try:
    with open("src/snowflake/retail_copy.sql", "r") as sql_file:
        cur = ctx.cursor()
        try:
            sql_commands = sql_file.read()
            cur.execute(sql_commands)
            print("SQL script executed successfully.")
        finally:
            cur.close()
finally:
    ctx.close()
    print("Connection closed.")
    