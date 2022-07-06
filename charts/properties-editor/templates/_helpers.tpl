{{/*
Expand the name of the chart.
*/}}
{{- define "editor.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "editor.fullname" -}}
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
{{- define "editor.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "editor.labels" -}}
helm.sh/chart: {{ include "editor.chart" . }}
{{ include "editor.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "editor.selectorLabels" -}}
app.kubernetes.io/name: {{ include "editor.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "editor.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "editor.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*

*/}}
{{- define "editor.localStoragePath" -}}
{{- if .Values.localStorage.enabled }}
{{- printf "%s/containers/properties-editor" .Values.localStorage.path }}
{{- end }}
{{- end }}

{{/*

*/}}
{{- define "editor.localStorageClinicPath" -}}
{{- if .Values.localStorage.enabled }}
{{- printf "%s/%s" .Values.localStorage.path .Values.clinicSlug }}
{{- end }}
{{- end }}