.PHONY: lint
lint:
	pre-commit run --all-files

.PHONY: local-init
local-init:
	tools/local-init
