.PHONY: help install start dev build run stop logs clean test

# Variables
IMAGE_NAME := simple-nodejs-api
CONTAINER_NAME := simple-api
PORT := 3000

help: ## Display this help message
	@echo "Simple Node.js API - Makefile Commands"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

# Local Development
install: ## Install dependencies
	npm install

start: ## Start application locally
	npm start

dev: ## Run in development mode
	npm run dev

# Container Commands
build: ## Build container image
	docker build -t $(IMAGE_NAME) .

run: ## Run container in background
	docker run -d -p $(PORT):3000 --name $(CONTAINER_NAME) $(IMAGE_NAME)
	@echo "✓ Container running at http://localhost:$(PORT)"

stop: ## Stop and remove container
	docker stop $(CONTAINER_NAME) 2>/dev/null || true
	docker rm $(CONTAINER_NAME) 2>/dev/null || true
	@echo "✓ Container stopped"

logs: ## View container logs
	docker logs -f $(CONTAINER_NAME)

# Testing
test: ## Test API endpoints
	@echo "Testing API..."
	@curl -s http://localhost:$(PORT)/health | head -c 100
	@echo "\n✓ API is running"

# Cleanup
clean: ## Remove container and image
	docker stop $(CONTAINER_NAME) 2>/dev/null || true
	docker rm $(CONTAINER_NAME) 2>/dev/null || true
	docker rmi $(IMAGE_NAME) 2>/dev/null || true
	@echo "✓ Cleaned up"

.DEFAULT_GOAL := help
