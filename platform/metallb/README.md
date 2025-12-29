# metallb

Metallb is a load balancer for Kubernetes. Specifically used for local development or bare metal clusters.

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

## Description

Installs MetalLB

<!-- markdownlint-disable MD034 -->

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://metallb.github.io/metallb | metallb | 0.* |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ipAddressPool.addresses | list | `["172.19.0.100-172.19.0.150"]` | A list of IP address ranges over which MetalLB has authority to serve. |
| ipAddressPool.name | string | `"public"` | The name of the IP address pool. |
| l2Advertisement | object | `{"ipAddressPools":["public"],"name":"metallb-l2-advertisement"}` | Allows advertising of LoadBalancer IPs provided by pools via L2. |
| l2Advertisement.ipAddressPools | list | `["public"]` | The list of IpAddressPools to advertise via this advetisement. Selected by name. |
| l2Advertisement.name | string | `"metallb-l2-advertisement"` | The name of the L2 advertisement. |
| metallb | object | `{"controller":{"nodeSelector":{"tier":"internal"}}}` | Metallb configuration. |
| metallb.controller | object | `{"nodeSelector":{"tier":"internal"}}` | Controller configuration. |
| metallb.controller.nodeSelector | object | `{"tier":"internal"}` | Node selector for the controller. |
| metallb.controller.nodeSelector.tier | string | `"internal"` | Deploy to the nodes with the tier label set to internal |

<!-- markdownlint-enable MD034 -->
