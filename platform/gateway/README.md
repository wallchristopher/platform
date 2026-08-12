# gateway

Gateway is a platform for deploying and managing applications on Kubernetes.

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

## Description

Installs Envoy Gateway

<!-- markdownlint-disable MD034 -->

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://docker.io/envoyproxy | gateway-crds-helm | 1.* |
| oci://docker.io/envoyproxy | controller(gateway-helm) | 1.* |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| controller.config | object | `{"envoyGateway":{"gateway":{"controllerName":"gateway.envoyproxy.io/gatewayclass-controller"}}}` | Controller Configuration |
| controller.config.envoyGateway | object | `{"gateway":{"controllerName":"gateway.envoyproxy.io/gatewayclass-controller"}}` | EnvoyGateway configuration. Visit https://gateway.envoyproxy.io/docs/api/extension_types/#envoygateway to view all options. |
| controller.config.envoyGateway.gateway.controllerName | string | `"gateway.envoyproxy.io/gatewayclass-controller"` | Name of the controller to use. This is currently the default but is referenced by our gatewayclass template. |
| public.envoyProxy | object | `{"name":"envoy-gateway","service":{"http":{"nodePort":30080,"port":80},"type":"NodePort"}}` | envoyProxy configures the generated Envoy data plane. |
| public.envoyProxy.name | string | `"envoy-gateway"` | name is the namespaced EnvoyProxy referenced by the Gateway. |
| public.envoyProxy.service | object | `{"http":{"nodePort":30080,"port":80},"type":"NodePort"}` | service configures the generated Envoy Service. |
| public.envoyProxy.service.http | object | `{"nodePort":30080,"port":80}` | http configures the public HTTP Service port. |
| public.envoyProxy.service.http.nodePort | int | `30080` | nodePort is the stable port reached from the EKS network. |
| public.envoyProxy.service.http.port | int | `80` | port is the Envoy Service port matched by the strategic merge patch. |
| public.envoyProxy.service.type | string | `"NodePort"` | type publishes Envoy through a fixed Kubernetes NodePort. |
| public.gateway | object | `{"listeners":{"http":{"allowedRoutes":{"kinds":[{"group":"gateway.networking.k8s.io","kind":"HTTPRoute"}],"namespaces":{"from":"All"}},"port":80,"protocol":"HTTP"}},"name":"envoy-gateway"}` | gateway configuration |
| public.gateway.listeners | object | `{"http":{"allowedRoutes":{"kinds":[{"group":"gateway.networking.k8s.io","kind":"HTTPRoute"}],"namespaces":{"from":"All"}},"port":80,"protocol":"HTTP"}}` | listeners configuration |
| public.gateway.name | string | `"envoy-gateway"` | gateway name |
| public.gatewayClass | object | `{"description":"Public gateway class for the platform","name":"public"}` | gateway class configuration |
| public.gatewayClass.description | string | `"Public gateway class for the platform"` | gateway class description |
| public.gatewayClass.name | string | `"public"` | gateway class name |

<!-- markdownlint-enable MD034 -->
