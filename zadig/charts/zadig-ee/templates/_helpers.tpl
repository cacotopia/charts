{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "plutus-vendor.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "plutus-vendor.fullname" -}}
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
{{- define "plutus-vendor.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "plutus-vendor.labels" -}}
helm.sh/chart: {{ include "plutus-vendor.chart" . }}
{{ include "plutus-vendor.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "vendor-portal.labels" -}}
helm.sh/chart: {{ include "plutus-vendor.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "plutus-vendor.selectorLabels" -}}
app.kubernetes.io/name: {{ include "plutus-vendor.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "plutus-vendor.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "plutus-vendor.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "plutus-vendor.port" -}}
29000
{{- end }}

{{/*
=====================================================
=          FRONTEND MICROSERVICE SETTINGS           =
=====================================================
*/}}
{{- define "plutus-vendor.portal.labels" -}}
app.kubernetes.io/component: vendor-portal
app.kubernetes.io/instance: vendor-portal
app.kubernetes.io/name: vendor-portal
{{ include "vendor-portal.labels" . }}
{{- end }}

{{- define "plutus-vendor.portal.selectorLabels" -}}
app.kubernetes.io/component: vendor-portal
app.kubernetes.io/instance: vendor-portal
app.kubernetes.io/name: vendor-portal
{{- end }}
