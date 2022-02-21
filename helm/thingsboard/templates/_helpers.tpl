{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "thingsboard.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "thingsboard.fullname" -}}
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
{{- define "thingsboard.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "thingsboard.labels" -}}
helm.sh/chart: {{ include "thingsboard.chart" . }}
{{ include "thingsboard.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "thingsboard.selectorLabels" -}}
app.kubernetes.io/name: {{ include "thingsboard.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "thingsboard.selectorLabelsNode" -}}
app.kubernetes.io/name: {{ include "thingsboard.name" . }}-node
app.kubernetes.io/instance: {{ .Release.Name }}-node
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "thingsboard.node.serviceAccountName" -}}
{{- if .Values.node.serviceAccount.create }}
{{- default (include "thingsboard.fullname" .) .Values.node.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.node.serviceAccount.name }}
{{- end }}
{{- end }}
