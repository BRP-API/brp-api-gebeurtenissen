{{/*
Expand the name of the chart.
*/}}
{{- define "axon-prod.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "axon-prod.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "axon-prod.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "axon-prod.labels" -}}
helm.sh/chart: {{ include "axon-prod.chart" . }}
{{ include "axon-prod.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "axon-prod.selectorLabels" -}}
app.kubernetes.io/name: {{ include "axon-prod.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "axon-prod.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "axon-prod.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Name of the headless gRPC service that governs the StatefulSet.
*/}}
{{- define "axon-prod.grpcServiceName" -}}
{{- printf "%s-grpc" (include "axon-prod.fullname" .) }}
{{- end }}

{{/*
Create the image path for the passed-in image field.
Supports both tag-based and digest-based references.
*/}}
{{- define "axon-prod.image" -}}
{{- if eq (substr 0 7 .tag) "sha256:" -}}
{{- printf "%s@%s" .repository .tag -}}
{{- else -}}
{{- printf "%s:%s" .repository .tag -}}
{{- end -}}
{{- end -}}

{{/*
Condense a list into a comma-separated string (mirrors poam utility).
*/}}
{{- define "axon-prod.util.condense-list" -}}
{{- if kindIs "slice" . -}}
{{- join "," . -}}
{{- else -}}
{{- . }}
{{- end -}}
{{- end -}}
