# argo

Argo is a platform for deploying and managing applications on Kubernetes.

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

## Description

Installs ArgoCD

<!-- markdownlint-disable MD034 -->

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://argoproj.github.io/argo-helm | argo-cd | 9.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| argo-cd.global | object | `{"nodeSelector":{"tier":"internal"}}` | Globally shared configuration |
| argo-cd.global.nodeSelector | object | `{"tier":"internal"}` | Node selector for all components |
| argo-cd.spec.destination.server | string | `"https://kubernetes.default.svc"` |  |
| argo-cd.spec.project | string | `"platform"` |  |
| argo-cd.spec.source.path | string | `"platform/platform/argocd"` |  |
| argo-cd.spec.source.repoURL | string | `"https://github.com/wallchristopher/platform"` |  |
| argo-cd.spec.source.targetRevision | string | `"HEAD"` |  |

<!-- markdownlint-enable MD034 -->
