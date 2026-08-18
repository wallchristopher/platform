# reloader

Installs opt-in Reloader for Platform-managed namespaces.

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.4.21](https://img.shields.io/badge/AppVersion-v1.4.21-informational?style=flat-square)

## Opt in

This wrapper installs [Reloader](https://github.com/stakater/Reloader) and limits it
to namespaces labeled `platform-reloader=enabled`. It does not annotate application
workloads.

Both opt-in steps are required. First, label the namespace:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: example
  labels:
    platform-reloader: "enabled"
```

Then add the automatic reload annotation to the workload metadata:

```yaml
metadata:
  annotations:
    reloader.stakater.com/auto: "true"
```

Reloader rolls the workload when a referenced Secret or ConfigMap changes.

<!-- markdownlint-disable MD034 -->

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://stakater.github.io/stakater-charts | reloader | 2.2.16 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| reloader | object | `{"reloader":{"namespaceSelector":"platform-reloader=enabled"}}` | reloader configures opt-in Secret and ConfigMap rollouts in selected namespaces. |

<!-- markdownlint-enable MD034 -->
