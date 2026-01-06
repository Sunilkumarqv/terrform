import os
import re
import snowflake.connector

# =========================
# 1. Load Connection Parameters from Environment
# =========================
account = os.getenv("SNOWFLAKE_ACCOUNT")
user = os.getenv("SNOWFLAKE_USER")
password = os.getenv("SNOWFLAKE_PASSWORD")
role = os.getenv("SNOWFLAKE_ROLE") or "PUBLIC"
warehouse = os.getenv("SNOWFLAKE_WAREHOUSE")
database = os.getenv("SNOWFLAKE_DATABASE")
schema = os.getenv("SNOWFLAKE_SCHEMA")

# =========================
# 2. Connect to Snowflake
# =========================
ctx = snowflake.connector.connect(
    user=user,
    password=password,
    account=account,
    role=role,
    warehouse=warehouse,
    database=database,
    schema=schema
)

print("✅ Connected successfully to Snowflake")

# =========================
# 3. Function: Run SQL File
# =========================
def run_sql_file(file_path):
    """
    Reads and executes each SQL statement in the given file.
    Removes comments and skips empty statements.
    """
    cur = ctx.cursor()
    try:
        with open(file_path, 'r') as f:
            sql_script = f.read()

        # Remove block comments /* ... */ and single-line comments -- ...
        sql_script = re.sub(r'/\*.*?\*/', '', sql_script, flags=re.S)
        sql_script = re.sub(r'--.*', '', sql_script)

        # Split by semicolon; strip whitespace and skip blank entries
        statements = [stmt.strip() for stmt in sql_script.split(';') if stmt.strip()]

        print(f"📄 Found {len(statements)} SQL statements in {file_path}")

        # Execute each statement one at a time
        for idx, stmt in enumerate(statements, start=1):
            print(f"▶ [{idx}/{len(statements)}] Running: {stmt[:100]}{'...' if len(stmt) > 100 else ''}")
            try:
                cur.execute(stmt)
                try:
                    results = cur.fetchall()
                    if results:
                        print(f"   📊 Results: {results}")
                except snowflake.connector.errors.ProgrammingError:
                    # No results to fetch for DDL/DML
                    pass
            except snowflake.connector.errors.ProgrammingError as e:
                print(f"   ❌ Error executing statement: {e}")
                # Uncomment below to stop execution on error
                # raise
    finally:
        cur.close()

# =========================
# 4. Run Your SQL Script
# =========================
try:
    run_sql_file("src/snowflake/retail_copy.sql")
finally:
    ctx.close()
    print("🔒 Connection closed")
