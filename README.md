# LeadsHug runtime workspace

This repository composes the current LeadsHug services. Product authority lives
in `foundation_documentation`; implementation lives in the API and Web
submodules.

## Components

| Path | Role | Technology |
| --- | --- | --- |
| `api-app` | API and domain services | NestJS, Prisma, PostgreSQL |
| `web-app` | Browser application | React, Vite, Nginx |
| `foundation_documentation` | Product decisions, TODOs, and contracts | LeadsHug Foundation |
| `delphi-ai` | Local engineering rules and tools | PACED / Delphi |

Flutter and Laravel are not part of this workspace. A future mobile application
will be introduced as a separate submodule when it has a defined contract.

## Local startup

1. Initialize all submodules:

   ```bash
   git submodule update --init --recursive
   ```

2. Create local configuration and set the three required secrets:

   ```bash
   cp .env.example .env
   # Generate values, for example: openssl rand -hex 32
   ```

   Set `SESSION_SECRET`, `INTERNAL_SERVICE_TOKEN`, and `WHATSAPP_TOKEN` in
   `.env`. Do not commit this file.

3. Build and start the complete local stack:

   ```bash
   make up
   ```

4. Confirm the API is healthy, then open the Web application:

   ```bash
   curl http://localhost:3000/health
   # http://localhost:8080
   ```

The local PostgreSQL endpoint is `localhost:55433`. Its credentials and database
name come from `.env` and have development defaults in `.env.example`.

## Useful commands

```bash
make ps
make logs
make migrate
make test-api
make test-web
make down
```

## Continuous integration

The root workflow validates Compose and runs the API and Web suites independently.
Because those repositories are private submodules, configure the GitHub Actions
secret `SUBMODULES_REPO_TOKEN` with read access to both repositories before
merging a pull request.

## Delphi

The first checkout needs Delphi configured locally:

```bash
bash delphi-ai/init.sh
bash delphi-ai/verify_context.sh --repair
bash delphi-ai/verify_context.sh
```

The Foundation constitution is the project-specific authority. Do not infer a
runtime target, database, tenant policy, or deployment configuration merely from
the presence of a Delphi capability.
