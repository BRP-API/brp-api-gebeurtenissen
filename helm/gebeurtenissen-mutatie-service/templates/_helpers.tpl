{{- define "gebeurtenissen-mutatie-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "gebeurtenissen-mutatie-service.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- include "gebeurtenissen-mutatie-service.name" . -}}
{{- end -}}
{{- end -}}

{{- define "gebeurtenissen-mutatie-service.labels" -}}
app.kubernetes.io/name: {{ include "gebeurtenissen-mutatie-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{- define "gebeurtenissen-mutatie-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gebeurtenissen-mutatie-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
