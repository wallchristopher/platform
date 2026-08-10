
# bootstrap

Manages the Platform root, project, and generated applications.

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

## Description

Bootstraps the Platform Argo CD resources.

<!-- markdownlint-disable MD034 -->

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| appProject | object | `{"clusterResourceWhitelist":[{"group":"*","kind":"*"}],"description":"Platform Project","destinations":[{"namespace":"*","server":"*"}],"finalizers":["resources-finalizer.argocd.argoproj.io"],"name":"platform","sourceRepos":["*"]}` | appProject configures the Platform Argo CD AppProject. |
| appProject.clusterResourceWhitelist | list | `[{"group":"*","kind":"*"}]` | clusterResourceWhitelist lists cluster-scoped resources permitted by the AppProject. |
| appProject.clusterResourceWhitelist[0].group | string | `"*"` | group matches permitted Kubernetes API groups. |
| appProject.clusterResourceWhitelist[0].kind | string | `"*"` | kind matches permitted cluster-scoped resource kinds. |
| appProject.description | string | `"Platform Project"` | description describes the AppProject. |
| appProject.destinations | list | `[{"namespace":"*","server":"*"}]` | destinations lists deployment targets permitted by the AppProject. |
| appProject.destinations[0].namespace | string | `"*"` | namespace matches namespaces permitted by this destination. |
| appProject.destinations[0].server | string | `"*"` | server matches cluster APIs permitted by this destination. |
| appProject.finalizers | list | `["resources-finalizer.argocd.argoproj.io"]` | finalizers control deletion of resources owned through the AppProject. |
| appProject.name | string | `"platform"` | name is the AppProject name. |
| appProject.sourceRepos | list | `["*"]` | sourceRepos lists Git repositories permitted by the AppProject. |
| application | object | `{"destination":{"namespace":"argocd","server":"https://kubernetes.default.svc"},"name":"platform","project":"default","source":{"helm":{"parameters":[{"name":"sourceRevision","value":"$ARGOCD_APP_SOURCE_TARGET_REVISION"},{"name":"resolvedRevision","value":"$ARGOCD_APP_REVISION"}]},"path":"platform/bootstrap","repoURL":"https://github.com/wallchristopher/platform.git"},"syncPolicy":{"automated":{"prune":true,"selfHeal":true}}}` | application configures the self-managed root Argo CD Application. |
| application.destination | object | `{"namespace":"argocd","server":"https://kubernetes.default.svc"}` | destination configures the root deployment target. |
| application.destination.namespace | string | `"argocd"` | namespace is the root destination namespace. |
| application.destination.server | string | `"https://kubernetes.default.svc"` | server is the root destination cluster API. |
| application.name | string | `"platform"` | name is the root Application name. |
| application.project | string | `"default"` | project is the AppProject used by the root Application. |
| application.source | object | `{"helm":{"parameters":[{"name":"sourceRevision","value":"$ARGOCD_APP_SOURCE_TARGET_REVISION"},{"name":"resolvedRevision","value":"$ARGOCD_APP_REVISION"}]},"path":"platform/bootstrap","repoURL":"https://github.com/wallchristopher/platform.git"}` | source configures the root Git and Helm source. |
| application.source.helm | object | `{"parameters":[{"name":"sourceRevision","value":"$ARGOCD_APP_SOURCE_TARGET_REVISION"},{"name":"resolvedRevision","value":"$ARGOCD_APP_REVISION"}]}` | helm configures parameters passed during root self-management. |
| application.source.helm.parameters | list | `[{"name":"sourceRevision","value":"$ARGOCD_APP_SOURCE_TARGET_REVISION"},{"name":"resolvedRevision","value":"$ARGOCD_APP_REVISION"}]` | parameters preserve the symbolic revision and resolved commit across self-management. |
| application.source.helm.parameters[0].name | string | `"sourceRevision"` | name identifies the symbolic-revision Helm parameter. |
| application.source.helm.parameters[0].value | string | `"$ARGOCD_APP_SOURCE_TARGET_REVISION"` | value reads the configured symbolic revision from Argo's build environment. |
| application.source.helm.parameters[1].name | string | `"resolvedRevision"` | name identifies the resolved-revision Helm parameter. |
| application.source.helm.parameters[1].value | string | `"$ARGOCD_APP_REVISION"` | value reads the immutable commit from Argo's build environment. |
| application.source.path | string | `"platform/bootstrap"` | path is the chart path reconciled by the root Application. |
| application.source.repoURL | string | `"https://github.com/wallchristopher/platform.git"` | repoURL is the Git repository reconciled by the root Application. |
| application.syncPolicy | object | `{"automated":{"prune":true,"selfHeal":true}}` | syncPolicy configures automated root reconciliation. |
| application.syncPolicy.automated | object | `{"prune":true,"selfHeal":true}` | automated enables automated root reconciliation. |
| application.syncPolicy.automated.prune | bool | `true` | prune removes root-owned resources deleted from Git. |
| application.syncPolicy.automated.selfHeal | bool | `true` | selfHeal corrects live drift from the root's desired state. |
| applicationSet | object | `{"applications":{"argocd":{"destination":{"namespace":"argocd","server":"https://kubernetes.default.svc"},"finalizers":["resources-finalizer.argocd.argoproj.io"],"project":"platform","source":{"helm":{"releaseName":"argocd","valueFiles":["values.yaml","values/local.yaml"]},"path":"platform/argocd","repoURL":"https://github.com/wallchristopher/platform.git"},"stage":"argocd","syncPolicy":{"automated":{"prune":true,"selfHeal":true},"retry":{"backoff":{"duration":"5s","factor":2,"maxDuration":"3m"},"limit":5},"syncOptions":["CreateNamespace=true","ServerSideApply=true"]}},"gateway":{"destination":{"namespace":"envoy-gateway-system","server":"https://kubernetes.default.svc"},"finalizers":["resources-finalizer.argocd.argoproj.io"],"project":"platform","source":{"helm":{"releaseName":"envoy-gateway","valueFiles":["values.yaml"]},"path":"platform/gateway","repoURL":"https://github.com/wallchristopher/platform.git"},"stage":"gateway","syncPolicy":{"automated":{"prune":true,"selfHeal":true},"retry":{"backoff":{"duration":"5s","factor":2,"maxDuration":"3m"},"limit":5},"syncOptions":["CreateNamespace=true","ServerSideApply=true"]}}},"name":"platform","stageLabelKey":"platform-bootstrap-stage","stages":["gateway","argocd"],"syncPolicy":{"applicationsSync":"sync","preserveResourcesOnDeletion":false},"template":{"destination":{"namespace":"argocd","server":"https://kubernetes.default.svc"},"project":"platform"}}` | applicationSet configures generated Applications and their RollingSync order. |
| applicationSet.applications | object | `{"argocd":{"destination":{"namespace":"argocd","server":"https://kubernetes.default.svc"},"finalizers":["resources-finalizer.argocd.argoproj.io"],"project":"platform","source":{"helm":{"releaseName":"argocd","valueFiles":["values.yaml","values/local.yaml"]},"path":"platform/argocd","repoURL":"https://github.com/wallchristopher/platform.git"},"stage":"argocd","syncPolicy":{"automated":{"prune":true,"selfHeal":true},"retry":{"backoff":{"duration":"5s","factor":2,"maxDuration":"3m"},"limit":5},"syncOptions":["CreateNamespace=true","ServerSideApply=true"]}},"gateway":{"destination":{"namespace":"envoy-gateway-system","server":"https://kubernetes.default.svc"},"finalizers":["resources-finalizer.argocd.argoproj.io"],"project":"platform","source":{"helm":{"releaseName":"envoy-gateway","valueFiles":["values.yaml"]},"path":"platform/gateway","repoURL":"https://github.com/wallchristopher/platform.git"},"stage":"gateway","syncPolicy":{"automated":{"prune":true,"selfHeal":true},"retry":{"backoff":{"duration":"5s","factor":2,"maxDuration":"3m"},"limit":5},"syncOptions":["CreateNamespace=true","ServerSideApply=true"]}}}` | applications maps Application names to complete generated configurations. |
| applicationSet.applications.argocd | object | `{"destination":{"namespace":"argocd","server":"https://kubernetes.default.svc"},"finalizers":["resources-finalizer.argocd.argoproj.io"],"project":"platform","source":{"helm":{"releaseName":"argocd","valueFiles":["values.yaml","values/local.yaml"]},"path":"platform/argocd","repoURL":"https://github.com/wallchristopher/platform.git"},"stage":"argocd","syncPolicy":{"automated":{"prune":true,"selfHeal":true},"retry":{"backoff":{"duration":"5s","factor":2,"maxDuration":"3m"},"limit":5},"syncOptions":["CreateNamespace=true","ServerSideApply=true"]}}` | argocd configures the self-managed Argo CD Application. |
| applicationSet.applications.argocd.destination | object | `{"namespace":"argocd","server":"https://kubernetes.default.svc"}` | destination configures the Argo CD deployment target. |
| applicationSet.applications.argocd.destination.namespace | string | `"argocd"` | namespace is the Argo CD destination namespace. |
| applicationSet.applications.argocd.destination.server | string | `"https://kubernetes.default.svc"` | server is the Argo CD destination cluster API. |
| applicationSet.applications.argocd.finalizers | list | `["resources-finalizer.argocd.argoproj.io"]` | finalizers delete Argo-owned resources with the generated Application. |
| applicationSet.applications.argocd.project | string | `"platform"` | project is the AppProject used by Argo CD. |
| applicationSet.applications.argocd.source | object | `{"helm":{"releaseName":"argocd","valueFiles":["values.yaml","values/local.yaml"]},"path":"platform/argocd","repoURL":"https://github.com/wallchristopher/platform.git"}` | source configures the Argo CD Git and Helm source. |
| applicationSet.applications.argocd.source.helm | object | `{"releaseName":"argocd","valueFiles":["values.yaml","values/local.yaml"]}` | helm configures the Argo CD Helm release. |
| applicationSet.applications.argocd.source.helm.releaseName | string | `"argocd"` | releaseName is the Argo CD Helm release name. |
| applicationSet.applications.argocd.source.helm.valueFiles | list | `["values.yaml","values/local.yaml"]` | valueFiles lists Argo CD values files relative to its chart. |
| applicationSet.applications.argocd.source.path | string | `"platform/argocd"` | path is the Argo CD chart path. |
| applicationSet.applications.argocd.source.repoURL | string | `"https://github.com/wallchristopher/platform.git"` | repoURL is the Argo CD Git repository. |
| applicationSet.applications.argocd.stage | string | `"argocd"` | stage assigns Argo CD to its RollingSync health gate. |
| applicationSet.applications.argocd.syncPolicy | object | `{"automated":{"prune":true,"selfHeal":true},"retry":{"backoff":{"duration":"5s","factor":2,"maxDuration":"3m"},"limit":5},"syncOptions":["CreateNamespace=true","ServerSideApply=true"]}` | syncPolicy configures Argo CD reconciliation and retry. |
| applicationSet.applications.argocd.syncPolicy.automated | object | `{"prune":true,"selfHeal":true}` | automated enables automated Argo CD reconciliation. |
| applicationSet.applications.argocd.syncPolicy.automated.prune | bool | `true` | prune removes Argo CD resources deleted from Git. |
| applicationSet.applications.argocd.syncPolicy.automated.selfHeal | bool | `true` | selfHeal corrects Argo CD live drift. |
| applicationSet.applications.argocd.syncPolicy.retry | object | `{"backoff":{"duration":"5s","factor":2,"maxDuration":"3m"},"limit":5}` | retry configures bounded Argo CD sync retries. |
| applicationSet.applications.argocd.syncPolicy.retry.backoff | object | `{"duration":"5s","factor":2,"maxDuration":"3m"}` | backoff configures Argo CD retry timing. |
| applicationSet.applications.argocd.syncPolicy.retry.backoff.duration | string | `"5s"` | duration is the initial Argo CD retry delay. |
| applicationSet.applications.argocd.syncPolicy.retry.backoff.factor | int | `2` | factor multiplies each Argo CD retry delay. |
| applicationSet.applications.argocd.syncPolicy.retry.backoff.maxDuration | string | `"3m"` | maxDuration caps the Argo CD retry delay. |
| applicationSet.applications.argocd.syncPolicy.retry.limit | int | `5` | limit is the maximum Argo CD retry count. |
| applicationSet.applications.argocd.syncPolicy.syncOptions | list | `["CreateNamespace=true","ServerSideApply=true"]` | syncOptions lists Argo CD synchronization options. |
| applicationSet.applications.gateway | object | `{"destination":{"namespace":"envoy-gateway-system","server":"https://kubernetes.default.svc"},"finalizers":["resources-finalizer.argocd.argoproj.io"],"project":"platform","source":{"helm":{"releaseName":"envoy-gateway","valueFiles":["values.yaml"]},"path":"platform/gateway","repoURL":"https://github.com/wallchristopher/platform.git"},"stage":"gateway","syncPolicy":{"automated":{"prune":true,"selfHeal":true},"retry":{"backoff":{"duration":"5s","factor":2,"maxDuration":"3m"},"limit":5},"syncOptions":["CreateNamespace=true","ServerSideApply=true"]}}` | gateway configures the Envoy Gateway Application. |
| applicationSet.applications.gateway.destination | object | `{"namespace":"envoy-gateway-system","server":"https://kubernetes.default.svc"}` | destination configures the Gateway deployment target. |
| applicationSet.applications.gateway.destination.namespace | string | `"envoy-gateway-system"` | namespace is the Gateway destination namespace. |
| applicationSet.applications.gateway.destination.server | string | `"https://kubernetes.default.svc"` | server is the Gateway destination cluster API. |
| applicationSet.applications.gateway.finalizers | list | `["resources-finalizer.argocd.argoproj.io"]` | finalizers delete Gateway-owned resources with the generated Application. |
| applicationSet.applications.gateway.project | string | `"platform"` | project is the AppProject used by Gateway. |
| applicationSet.applications.gateway.source | object | `{"helm":{"releaseName":"envoy-gateway","valueFiles":["values.yaml"]},"path":"platform/gateway","repoURL":"https://github.com/wallchristopher/platform.git"}` | source configures the Gateway Git and Helm source. |
| applicationSet.applications.gateway.source.helm | object | `{"releaseName":"envoy-gateway","valueFiles":["values.yaml"]}` | helm configures the Gateway Helm release. |
| applicationSet.applications.gateway.source.helm.releaseName | string | `"envoy-gateway"` | releaseName is the Gateway Helm release name. |
| applicationSet.applications.gateway.source.helm.valueFiles | list | `["values.yaml"]` | valueFiles lists Gateway values files relative to its chart. |
| applicationSet.applications.gateway.source.path | string | `"platform/gateway"` | path is the Gateway chart path. |
| applicationSet.applications.gateway.source.repoURL | string | `"https://github.com/wallchristopher/platform.git"` | repoURL is the Gateway Git repository. |
| applicationSet.applications.gateway.stage | string | `"gateway"` | stage assigns Gateway to its RollingSync health gate. |
| applicationSet.applications.gateway.syncPolicy | object | `{"automated":{"prune":true,"selfHeal":true},"retry":{"backoff":{"duration":"5s","factor":2,"maxDuration":"3m"},"limit":5},"syncOptions":["CreateNamespace=true","ServerSideApply=true"]}` | syncPolicy configures Gateway reconciliation and retry. |
| applicationSet.applications.gateway.syncPolicy.automated | object | `{"prune":true,"selfHeal":true}` | automated enables automated Gateway reconciliation. |
| applicationSet.applications.gateway.syncPolicy.automated.prune | bool | `true` | prune removes Gateway resources deleted from Git. |
| applicationSet.applications.gateway.syncPolicy.automated.selfHeal | bool | `true` | selfHeal corrects Gateway live drift. |
| applicationSet.applications.gateway.syncPolicy.retry | object | `{"backoff":{"duration":"5s","factor":2,"maxDuration":"3m"},"limit":5}` | retry configures bounded Gateway sync retries. |
| applicationSet.applications.gateway.syncPolicy.retry.backoff | object | `{"duration":"5s","factor":2,"maxDuration":"3m"}` | backoff configures Gateway retry timing. |
| applicationSet.applications.gateway.syncPolicy.retry.backoff.duration | string | `"5s"` | duration is the initial Gateway retry delay. |
| applicationSet.applications.gateway.syncPolicy.retry.backoff.factor | int | `2` | factor multiplies each Gateway retry delay. |
| applicationSet.applications.gateway.syncPolicy.retry.backoff.maxDuration | string | `"3m"` | maxDuration caps the Gateway retry delay. |
| applicationSet.applications.gateway.syncPolicy.retry.limit | int | `5` | limit is the maximum Gateway retry count. |
| applicationSet.applications.gateway.syncPolicy.syncOptions | list | `["CreateNamespace=true","ServerSideApply=true"]` | syncOptions lists Gateway synchronization options. |
| applicationSet.name | string | `"platform"` | name is the ApplicationSet name. |
| applicationSet.stageLabelKey | string | `"platform-bootstrap-stage"` | stageLabelKey labels generated Applications for RollingSync matching. |
| applicationSet.stages | list | `["gateway","argocd"]` | stages orders generated Applications by required health gate. |
| applicationSet.syncPolicy | object | `{"applicationsSync":"sync","preserveResourcesOnDeletion":false}` | syncPolicy controls generated Application ownership and deletion. |
| applicationSet.syncPolicy.applicationsSync | string | `"sync"` | applicationsSync permits ApplicationSet create, update, and delete operations. |
| applicationSet.syncPolicy.preserveResourcesOnDeletion | bool | `false` | preserveResourcesOnDeletion removes generated resources when their Application is deleted. |
| applicationSet.template | object | `{"destination":{"namespace":"argocd","server":"https://kubernetes.default.svc"},"project":"platform"}` | template supplies the schema-required top-level ApplicationSet defaults. |
| applicationSet.template.destination | object | `{"namespace":"argocd","server":"https://kubernetes.default.svc"}` | destination supplies the schema-required top-level template destination. |
| applicationSet.template.destination.namespace | string | `"argocd"` | namespace is the top-level template destination namespace. |
| applicationSet.template.destination.server | string | `"https://kubernetes.default.svc"` | server is the top-level template destination cluster API. |
| applicationSet.template.project | string | `"platform"` | project supplies the schema-required top-level template project. |
| resolvedRevision | string | `"HEAD"` | resolvedRevision pins generated Applications to the immutable root commit. |
| sourceRevision | string | `"HEAD"` | sourceRevision preserves the symbolic Git revision followed by the root Application. |

<!-- markdownlint-enable MD034 -->
