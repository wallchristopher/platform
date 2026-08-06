LINT_FROM_REF := env("LINT_FROM_REF", "origin/main")
LINT_TO_REF := env("LINT_TO_REF", "HEAD")

set default-list := true

lint:
  pre-commit run --from-ref "{{LINT_FROM_REF}}" --to-ref "{{LINT_TO_REF}}"

lint-all:
  pre-commit run --all-files

local-bootstrap:
  tools/bootstrap

local-reset:
  tools/bootstrap recreate
