SHELL = /bin/bash

EXECUTABLES = composer
CHECK := $(foreach executable,$(EXECUTABLES),\
	$(if $(shell which $(executable)),"",$(error "No executable found for $(executable).")))

.PHONY: build clean help

.SILENT: help

default: help

build: ## Build the release 🚀.
	docker run --rm -it \
		-v $$(pwd):/usr/src/app \
		-v ~/.composer:/home/composer/.composer \
		-v ~/.ssh:/home/composer/.ssh:ro \
		graze/composer install
	mkdir -p build/
	tar -czf build/release.tar.gz public/ vendor/

clean: ## Cleanup.
	rm -rf build/

help: ## Show this help message.
	echo "usage: make [target] ..."
	echo ""
	echo "targets:"
	fgrep --no-filename "##" ${MAKEFILE_LIST} | fgrep --invert-match $$'\t' | sed -e 's/: ## / - /'
