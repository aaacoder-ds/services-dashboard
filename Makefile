.PHONY: help build run stop clean test deploy

# Default target
help:
	@echo "Available commands:"
	@echo "  build    - Build the Docker image"
	@echo "  run      - Run the container using docker-compose"
	@echo "  stop     - Stop the container"
	@echo "  clean    - Remove containers and images"
	@echo "  test     - Test the application locally"
	@echo "  deploy   - Build and push to registry (requires login)"

# Build the Docker image
build:
	docker build -t aaacoder-dashboard .

# Run the application using docker-compose
run:
	docker-compose up -d

# Stop the application
stop:
	docker-compose down

# Clean up containers and images
clean:
	docker-compose down --rmi all --volumes --remove-orphans
	docker rmi aaacoder-dashboard 2>/dev/null || true

# Test the application locally
test: build
	docker run --rm -p 8080:80 aaacoder-dashboard &
	@echo "Testing application at http://localhost:8080"
	@echo "Health check: http://localhost:8080/health"
	@sleep 3
	@curl -f http://localhost:8080/health || echo "Health check failed"
	@docker stop $$(docker ps -q --filter ancestor=aaacoder-dashboard) 2>/dev/null || true

# Deploy to registry (requires docker login)
deploy:
	@echo "Building and pushing to registry..."
	docker build -t ghcr.io/$(shell git config --get remote.origin.url | sed 's/.*github.com[:/]\([^/]*\/[^/]*\).*/\1/') .
	docker push ghcr.io/$(shell git config --get remote.origin.url | sed 's/.*github.com[:/]\([^/]*\/[^/]*\).*/\1/')

# Development server (without Docker)
dev:
	@echo "Starting development server..."
	@echo "Available at http://localhost:8080"
	@echo "Press Ctrl+C to stop"
	python3 -m http.server 8080

# Lint and validate
lint:
	@echo "Validating HTML..."
	@if command -v tidy >/dev/null 2>&1; then \
		tidy -q -e index.html; \
	else \
		echo "HTML Tidy not found. Skipping HTML validation."; \
	fi
	@echo "Validating Dockerfile..."
	@docker run --rm -i hadolint/hadolint < Dockerfile

# Show logs
logs:
	docker-compose logs -f

# Show status
status:
	docker-compose ps 