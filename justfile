CLUSTER_NAME := env("CLUSTER_NAME", "platform")

set default-list := true

lint:
  pre-commit run --all-files

local-bootstrap:
  CLUSTER_NAME="{{CLUSTER_NAME}}" tools/local-init

local-reset:
  if kind get clusters | grep -qx "{{CLUSTER_NAME}}"; then kind delete cluster --name "{{CLUSTER_NAME}}"; fi
  CLUSTER_NAME="{{CLUSTER_NAME}}" tools/local-init
