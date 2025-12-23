# argo-cd

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

<!-- markdownlint-enable MD034 -->
