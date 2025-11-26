
# dbt **on Snowflake** starter (WCC-style medallion)

This repository runs dbt *natively inside Snowflake* using `dbt Projects on Snowflake`.
The workflow uses the **Snowflake CLI** to deploy a DBT PROJECT object and then executes
dbt commands inside Snowflake (no Python runner needed).

**Highlights**
- Medallion folders (`landing/bronze/silver/gold`) and a tiny demo lineage.
- `profiles.yml` with **no passwords** (required for dbt Projects on Snowflake).
- GitHub Action triggers: manual (`workflow_dispatch`) and cross‑repo (`repository_dispatch`).

## Quick start (local optional)
You don't need local Python or dbt. If you want to inspect the project locally, that's fine,
but execution happens inside Snowflake.

## Snowflake prerequisites
Create the following once (adjust names as desired):

```sql
create warehouse if not exists COMPUTE_WH warehouse_size = 'XSMALL' auto_suspend = 60 initially_suspended = true;

create role if not exists DBT_DEV_ROLE;
grant usage on warehouse COMPUTE_WH to role DBT_DEV_ROLE;

-- Databases per medallion layer for DEV & TEST (adjust if you prefer different names)
create database if not exists DEV_LANDING;     create database if not exists TEST_LANDING;
create database if not exists DEV_BRONZE_ADF;  create database if not exists TEST_BRONZE_ADF;
create database if not exists DEV_SILVER;      create database if not exists TEST_SILVER;
create database if not exists DEV_GOLD;        create database if not exists TEST_GOLD;

-- Schemas that dbt will use as target schemas noted in profiles.yml
create schema if not exists DEV_LANDING.DBT_DEV;
create schema if not exists TEST_LANDING.DBT_TEST;
```

If your project uses **dbt packages** (e.g. `dbt_utils`), enable egress so Snowflake can run
`dbt deps` during deployment:

```sql
create or replace network rule DBT_HUB_RULE
  type = host_port
  mode = egress
  value_list = ('hub.getdbt.com:443','github.com:443');

create or replace external access integration DBT_EAI
  allowed_network_rules = (DBT_HUB_RULE)
  enabled = true;
```
(You'll reference `DBT_EAI` in the workflow’s `snow dbt deploy`.)

## GitHub secrets (in this repo)
- `SNOWFLAKE_ACCOUNT`   e.g. `xy12345.eu-west-2.aws`
- `SNOWFLAKE_USER`
- **One of** `SNOWFLAKE_PASSWORD` *or* `SNOWFLAKE_PRIVATE_KEY_B64` (base64 of your RSA PKCS#8)
- `SNOWFLAKE_ROLE`      e.g. `DBT_DEV_ROLE`
- `SNOWFLAKE_WAREHOUSE` e.g. `COMPUTE_WH`
- (Optional) `DBT_EXTERNAL_ACCESS_INTEGRATION` set to `DBT_EAI`

> Passwords must **not** be present in `profiles.yml` for dbt on Snowflake.

## Run it
- Manual: Actions → **dbt-on-snowflake** → *Run workflow* (choose `dev` or `test`).
- Cross‑repo: The ADF repo sends a `repository_dispatch` payload (see that repo).

Artifacts include the CLI output. You can also query `QUERY_HISTORY` in Snowflake.
