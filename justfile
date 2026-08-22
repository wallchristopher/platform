LINT_FROM_REF := env("LINT_FROM_REF", "origin/main")
LINT_TO_REF := env("LINT_TO_REF", "HEAD")

set default-list

[private]
helm-dependencies:
    #!/usr/bin/env bash
    set -euo pipefail
    shopt -s nullglob
    locks=(platform/*/Chart.lock)
    for lock in "${locks[@]}"; do
      helm dependency build "${lock%/Chart.lock}"
    done

lint: helm-dependencies
    pre-commit run --from-ref "{{ LINT_FROM_REF }}" --to-ref "{{ LINT_TO_REF }}"

lint-all: helm-dependencies
    pre-commit run --all-files

local-bootstrap:
    tools/bootstrap

local-recreate:
    tools/bootstrap recreate
