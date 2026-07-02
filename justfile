CLUSTER_NAME := env("CLUSTER_NAME", "platform")
LINT_FROM_REF := env("LINT_FROM_REF", "origin/main")
LINT_TO_REF := env("LINT_TO_REF", "HEAD")

set default-list := true

lint:
  pre-commit run --from-ref "{{LINT_FROM_REF}}" --to-ref "{{LINT_TO_REF}}"

lint-all:
  pre-commit run --all-files

local-bootstrap:
  CLUSTER_NAME="{{CLUSTER_NAME}}" tools/local-init

local-reset:
  if kind get clusters | grep -qx "{{CLUSTER_NAME}}"; then kind delete cluster --name "{{CLUSTER_NAME}}"; fi
  CLUSTER_NAME="{{CLUSTER_NAME}}" tools/local-init
