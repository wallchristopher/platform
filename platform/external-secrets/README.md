# external-secrets

Installs External Secrets Operator and Platform-managed ClusterSecretStores.

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.9.0](https://img.shields.io/badge/AppVersion-v2.9.0-informational?style=flat-square)

## What this chart manages

This wrapper installs [External Secrets Operator](https://external-secrets.io/) with
its controller, webhook, certificate controller, RBAC, and CRDs. Platform adds the
shared `ClusterSecretStore` resources and an optional credential Secret for local
Floci.

## Use the shared stores

A namespace may reference the shared stores only when it has this label:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: example
  labels:
    wallchristopher.github.io/secret-store-access: "enabled"
```

| Store | AWS service | Configured prefix |
| --- | --- | --- |
| `platform-ssm` | Systems Manager Parameter Store | `/platform/` |
| `platform-secrets-manager` | Secrets Manager | `platform/` |

## CRD lifecycle

The chart marks the upstream CRDs with `helm.sh/resource-policy: keep` and the Argo CD
`Prune=false,Delete=false` sync options. Removing the chart or Application leaves the
CRDs installed. Do not reconcile them with `Replace=true`. Before deleting a CRD
manually, verify that no External Secrets resources or finalizers remain.

<!-- markdownlint-disable MD034 -->

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.external-secrets.io | external-secrets | 2.9.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clusterSecretStores | object | `{"platform-secrets-manager":{"conditions":[{"namespaceSelector":{"matchLabels":{"wallchristopher.github.io/secret-store-access":"enabled"}}}],"provider":{"aws":{"prefix":"platform/","region":"us-east-1","service":"SecretsManager"}}},"platform-ssm":{"conditions":[{"namespaceSelector":{"matchLabels":{"wallchristopher.github.io/secret-store-access":"enabled"}}}],"provider":{"aws":{"prefix":"/platform/","region":"us-east-1","service":"ParameterStore"}}}}` | clusterSecretStores maps names to complete store specifications. |
| clusterSecretStores.platform-secrets-manager | object | `{"conditions":[{"namespaceSelector":{"matchLabels":{"wallchristopher.github.io/secret-store-access":"enabled"}}}],"provider":{"aws":{"prefix":"platform/","region":"us-east-1","service":"SecretsManager"}}}` | platform-secrets-manager exposes the shared Secrets Manager root. |
| clusterSecretStores.platform-ssm | object | `{"conditions":[{"namespaceSelector":{"matchLabels":{"wallchristopher.github.io/secret-store-access":"enabled"}}}],"provider":{"aws":{"prefix":"/platform/","region":"us-east-1","service":"ParameterStore"}}}` | platform-ssm exposes the shared Parameter Store root. |
| external-secrets | object | `{"crds":{"annotations":{"argocd.argoproj.io/sync-options":"Prune=false,Delete=false","helm.sh/resource-policy":"keep"}},"openshiftFinalizers":false}` | external-secrets configures the maintained operator dependency. |
| localCredentials | object | `{"accessKeyID":"","enabled":false,"name":"floci-credentials","secretAccessKey":""}` | localCredentials configures the optional local provider Secret. |
| localCredentials.accessKeyID | string | `""` | accessKeyID is the non-production provider access key ID. |
| localCredentials.enabled | bool | `false` | enabled creates the local provider credential Secret. |
| localCredentials.name | string | `"floci-credentials"` | name is the provider credential Secret name. |
| localCredentials.secretAccessKey | string | `""` | secretAccessKey is the non-production provider secret access key. |

<!-- markdownlint-enable MD034 -->
