/*set up objects*/
-- CREATE WAREHOUSE bau_wh WITH WAREHOUSE_SIZE='X-LARGE';
-- CREATE ROLE bau_developer_role;
-- CREATE DATABASE bau_bd;
-- CREATE SCHEMA bau_schema;

-- /*grant permission*/
-- GRANT CREATE STAGE ON SCHEMA public TO ROLE bau_developer_role;
-- GRANT USAGE ON INTEGRATION azure_integration TO ROLE bau_developer_role;

use warehouse bau_wh;
use database bau_bd;
use schema bau_schema;

/*intergation */
-- CREATE STORAGE INTEGRATION azure_integration
--   TYPE = EXTERNAL_STAGE
--   STORAGE_PROVIDER = 'AZURE'
--   ENABLED = TRUE
--   AZURE_TENANT_ID = 'd9e5da77-5bc4-4c91-9591-a074aaa4a832'
--   STORAGE_ALLOWED_LOCATIONS = ('azure://straccountretail.blob.core.windows.net/silver/', 'azure://straccountretail.blob.core.windows.net/bronze/')

-- /*check and authenticate*/
-- DESC STORAGE INTEGRATION azure_integration;




/*file format*/
CREATE OR REPLACE FILE FORMAT my_parquet_format TYPE = PARQUET;

/*createtable*/
CREATE OR REPLACE TABLE bau_schema.retail_fact (
InvoiceNo STRING,
StockCode INTEGER,
Description STRING,
Quantity INTEGER,
InvoiceDate DATE,
UnitPrice FLOAT,
CustomerID INTEGER,
Country STRING

);

/*stage table*/
CREATE OR REPLACE STAGE my_azure_stage
  STORAGE_INTEGRATION = azure_integration
  URL = 'azure://straccountretail.blob.core.windows.net/silver/online_retail_clean/'
  directory = (enable = true);


LIST @my_azure_stage;


/*copy comment*/

COPY INTO bau_schema.retail_fact
FROM @my_azure_stage
FILE_FORMAT = (TYPE = PARQUET)
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
ON_ERROR = SKIP_FILE;  -- or CONTINUE


//select * from bau_schema.retail_fact
 