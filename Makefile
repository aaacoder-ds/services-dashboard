.PHONY: help build run stop clean test deploy dev lint logs status test-cleanup

# Default target
help:
	@echo "Available commands:"
	@echo "  build    - Build the Docker image"
	@echo "  run      - Run the container using docker-compose"
	@echo "  stop     - Stop the container"
	@echo "  clean    - Remove containers and images"
	@echo "  test     - Test the application locally"
	@echo "  test-cleanup - Clean up test containers"
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
	@echo "Starting test container..."
	@docker run --rm --name test-dashboard -p 8080:80 aaacoder-dashboard &
	@echo "Testing application at http://localhost:8080"
	@echo "Health check: http://localhost:8080/health"
	@sleep 3
	@curl -f http://localhost:8080/health || (echo "Health check failed" && docker stop test-dashboard 2>/dev/null || true && exit 1)
	@echo "Health check passed!"
	@docker stop test-dashboard 2>/dev/null || true
	@echo "Test completed successfully"

# Clean up test containers (useful for manual cleanup)
test-cleanup:
	@echo "Cleaning up test containers..."
	@docker stop test-dashboard 2>/dev/null || true
	@docker rm test-dashboard 2>/dev/null || true
	@echo "Test cleanup completed"

# Deploy to registry (requires docker login)
deploy:
	@echo "Building and pushing to registry..."
deploy:
	@echo "Building and pushing to registry..."
	@REPO=$(git config --get remote.origin.url \
		| sed 's/.*github.com[:/]\([^/]*\/[^/]*\)\.git.*/\1/' \
		| sed 's/\.git$//'); \
	if [ -z "$REPO" ]; then \
		echo "Error: Could not determine repository name"; \
		exit 1; \
	fi; \
	echo "Building for repository: $REPO"; \
	docker build -t ghcr.io/$REPO:latest .; \
	docker push ghcr.io/$REPO:latest

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