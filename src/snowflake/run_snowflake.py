import os
import snowflake.connector

# Get environment variables
account = os.getenv("SNOWFLAKE_ACCOUNT")
user = os.getenv("SNOWFLAKE_USER")
password = os.getenv("SNOWFLAKE_PASSWORD")
role = os.getenv("SNOWFLAKE_ROLE")
warehouse = os.getenv("SNOWFLAKE_WAREHOUSE")
database = os.getenv("SNOWFLAKE_DATABASE")
schema = os.getenv("SNOWFLAKE_SCHEMA")

# Connect to Snowflake
ctx = snowflake.connector.connect(
    user=user,
    password=password,
    account=account,
    role=role,
    warehouse=warehouse,
    database=database,
    schema=schema
)

# Create cursor and execute query
cur = ctx.cursor()
try:
    cur.execute("SELECT CURRENT_VERSION()")
    version = cur.fetchone()[0]
    print(f"Snowflake version: {version}")
finally:
    cur.close()
    ctx.close()
