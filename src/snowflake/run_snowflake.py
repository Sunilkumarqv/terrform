import os
import snowflake.connector

# Load connection details from environment variables
account = os.getenv("SNOWFLAKE_ACCOUNT")
user = os.getenv("SNOWFLAKE_USER")
password = os.getenv("SNOWFLAKE_PASSWORD")
role = os.getenv("SNOWFLAKE_ROLE") or "PUBLIC"
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

def run_sql_file(filename):
    with open(filename, 'r') as f:
        sql_commands = f.read()
    cur = ctx.cursor()
    try:
        # Snowflake connector does not support multi-statement execution natively
        # Split by semicolon; ignore empty statements
        for stmt in sql_commands.split(';'):
            stmt = stmt.strip()
            if stmt:
                print(f"Running:{stmt[:120]}{'...' if len(stmt)>120 else ''}")
                cur.execute(stmt)
                try:
                    results = cur.fetchall()
                    print("Results:", results)
                except snowflake.connector.errors.ProgrammingError:
                    # no results to fetch
                    pass
    finally:
        cur.close()

# Run
try:
    print("Connected successfully.")
    run_sql_file("src/snowflake/retail_copy.sql")
finally:
    ctx.close()
    print("Connection closed.")
