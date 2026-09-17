SHELL := /bin/bash

.PHONY: up down ps logs test-api test-web migrate

up:
	docker compose up -d --build

down:
	docker compose down

ps:
	docker compose ps

logs:
	docker compose logs -f --tail=200

test-api:
	cd api-app && npm ci && npm run lint && npm run build && npm test

test-web:
	cd web-app && npm ci && npm run build && npm test

migrate:
	docker compose exec api npx prisma migrate deploy
