SHELL := /bin/bash
.PHONY: deps run test docker-build docker-run release hotfix help

help: ## Show this help message.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

deps: ## Download and tidy Go dependencies
	@go mod tidy

run: ## Run main.go file
	@go run ./main.go

test: ## Execute all test
	@go test -v

docker-build: ## Build docker image locally
	@docker buildx build --platform linux/amd64,linux/arm64 -t juliopedrosa/webapp:latest .

docker-run:
	@docker run -p 8080:3000 -d --hostname mycontainer-host juliopedrosa/webapp:latest

release: ## Create release
	./scripts/create_release.sh

hotfix: ## Create hotfix
	./scripts/create_hotfix.sh
