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

#read and execute the SQL file
# with open("src/snowflake/snowflake.sql", "r") as file:
#     sql_commands = file.read() 
#     with ctx.cursor() as cs:
#         cs.execute(sql_commands)
#         print("SQL script executed successfully.")
# ctx.close()

#remove /* comments from the SQL file
with open("src/snowflake/snowflake.sql", "r") as file:
    sql_content = file.read()   
    import re
    cleaned_sql = re.sub(r'/\*.*?\*/', '', sql_content, flags=re.DOTALL)
    with open("src/snowflake/snowflake_cleaned.sql", "w") as cleaned_file:
        cleaned_file.write(cleaned_sql)
print("Comments removed and cleaned SQL file created.")

#reand and execute the cleaned SQL file
with open("src/snowflake/snowflake_cleaned.sql", "r") as file:
    sql_commands = file.read() 
    with ctx.cursor() as cs:
        cs.execute(sql_commands)
        print("Cleaned SQL script executed successfully.")  