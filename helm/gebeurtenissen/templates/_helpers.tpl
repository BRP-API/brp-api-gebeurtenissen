{{- define "gebeurtenissen.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "gebeurtenissen.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- include "gebeurtenissen.name" . -}}
{{- end -}}
{{- end -}}

{{- define "gebeurtenissen.labels" -}}
app.kubernetes.io/name: {{ include "gebeurtenissen.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{- define "gebeurtenissen.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gebeurtenissen.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
