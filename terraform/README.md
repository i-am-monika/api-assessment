# Task API Assessment

A containerized REST API for task management, backed by Postgres, with full infrastructure as code and CI/CD.

## Architecture

- **VPC**: Custom VPC with 2 public + 2 private subnets across 2 AZs, IGW, and NAT gateway (Terraform)
- **Compute**: EC2 instance (public subnet) running the containerized Node.js API
- **Database**: PostgreSQL (containerized — see note below)
- **CI/CD**: GitHub Actions — builds and pushes the Docker image to GitHub Container Registry (GHCR) on every push; runs `terraform plan` on PRs and `terraform apply` on merge to master

## Local Development Note

This project was built and tested against **LocalStack (free/community tier)** rather than a real AWS account, since AWS requires a payment card to activate. As a result:
- **RDS and ECS/Fargate are LocalStack Pro-only features** — the assessment substitutes a **Postgres Docker container** (in place of RDS) and an **EC2 instance running the app container** (in place of ECS/Fargate) to keep the exercise fully runnable end-to-end for free.
- The `terraform-apply` CI job targets `localhost:4566` and is expected to fail in GitHub Actions, since GitHub's runners can't reach a local Codespace. In a production setup, this would run against real AWS using OIDC-based credentials and remote state (S3 + DynamoDB).

## Running Locally

1. Start LocalStack and Postgres (see `docker run` commands in `terraform/` and root)
2. `cd terraform && terraform init && terraform apply`
3. `cd app && npm install && node server.js`
4. Test: `curl http://localhost:3000/health`

## API Endpoints

- `GET /health` — DB connectivity check
- `GET /tasks` — list all tasks
- `POST /tasks` — create a task (`{ "title": "...", "description": "..." }`)
- `PATCH /tasks/:id` — update task status
- `DELETE /tasks/:id` — delete a task
