{{/*
Expand the name of the chart.
*/}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gebeurtenissen-mutatie-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "gebeurtenissen-mutatie-service.labels" -}}
helm.sh/chart: {{ include "gebeurtenissen-mutatie-service.chart" . }}
{{ include "gebeurtenissen-mutatie-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "gebeurtenissen-mutatie-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gebeurtenissen-mutatie-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "gebeurtenissen-mutatie-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "gebeurtenissen-mutatie-service.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}
