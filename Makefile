.PHONY: docs

default: install

all: install build

# Default directory (can be overridden with DIR=<path>)
DIR ?= tech

h help:
	@grep '^[a-z]' Makefile
	@echo "Usage:"
	@echo "  make install DIR=tech           # Install dependencies for 'tech'"
	@echo "  make install DIR=knowledge-base # Install dependencies for 'knowledge-base'"
	@echo "  make build DIR=tech             # Build documentation for 'tech'"
	@echo "  make deploy DIR=knowledge-base  # Deploy 'knowledge-base' documentation"

install:
	pip install pip --upgrade
	pip install -r $(DIR)requirements.txt

upgrade:
	pip install pip --upgrade
	pip install -r $(DIR)requirements.txt --upgrade

s serve:
	mkdocs serve --strict --config-file $(DIR)/mkdocs.yml

b build:
	mkdocs build --strict --config-file $(DIR)/mkdocs.yml

d deploy-tech:
	mkdocs gh-deploy --strict --config-file $(DIR)/mkdocs.yml --force

e deploy-kb:
	mkdocs gh-deploy --strict --config-file $(DIR)/mkdocs.yml --force --remote-branch gh-pages-kb