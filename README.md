# Optio Analytics - dbt + Snowflake

dbt project for analytics transformations deployed to Snowflake via GitHub Actions.

## Setup

### Local Development

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Set up environment variables:
```bash
cp env.example .env
# Edit .env with your actual credentials
```

3. Load env vars (run this after each terminal restart):
```bash
source .env
```

4. Test connection:
```bash
dbt debug --profiles-dir .
```

5. Run models:
```bash
dbt build --profiles-dir .
```

### GitHub Actions Secrets

Configure these secrets in your repo settings:

| Secret | Description |
|--------|-------------|
| `SNOWFLAKE_ACCOUNT` | Snowflake account identifier (e.g., `abc12345.us-east-1`) |
| `SNOWFLAKE_USER` | Service account username |
| `SNOWFLAKE_PASSWORD` | Service account password |
| `SNOWFLAKE_ROLE` | Snowflake role with transform permissions |
| `SNOWFLAKE_DATABASE` | Target database |
| `SNOWFLAKE_WAREHOUSE` | Compute warehouse |
| `SNOWFLAKE_SCHEMA` | Default schema |

## Project Structure

```
├── models/
│   ├── staging/          # Source-aligned models (views)
│   │   ├── stg_customers.sql
│   │   └── stg_orders.sql
│   └── marts/            # Business logic models (tables)
│       └── fct_orders.sql
├── .github/workflows/    # CI/CD
└── profiles.yml          # Connection config
```

## Workflow

- **PR**: Runs `dbt build` against dev target for validation
- **Merge to main**: Deploys to production target
