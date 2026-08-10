{{- define "bootstrap.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "bootstrap.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "bootstrap.namespace" -}}
{{- .Release.Namespace -}}
{{- end -}}

{{- define "bootstrap.labels" -}}
helm.sh/chart: {{ include "bootstrap.chart" . | quote }}
app.kubernetes.io/name: {{ include "bootstrap.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
{{- end -}}
