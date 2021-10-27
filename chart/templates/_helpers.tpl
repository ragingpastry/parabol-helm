{{/*
Expand the name of the chart.
*/}}
{{- define "parabol.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "parabol.rethinkdb.name" -}}
{{- printf "%s-rethinkdb" .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "parabol.fullname" -}}
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
{{- define "parabol.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "parabol.labels" -}}
helm.sh/chart: {{ include "parabol.chart" . }}
{{ include "parabol.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "parabol.rethinkdb.labels" -}}
helm.sh/chart: {{ include "parabol.chart" . }}
{{ include "parabol.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "parabol.selectorLabels" -}}
app.kubernetes.io/name: {{ include "parabol.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "parabol.rethinkdb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "parabol.rethinkdb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "parabol.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "parabol.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "parabol.parabol-storage" -}}
  {{- printf "%s-data" (include "parabol.fullname" .) -}}
{{- end -}}

{{- define "parabol.rethinkdb-storage" -}}
  {{- printf "%s-rethinkdb-data" (include "parabol.fullname" .) -}}
{{- end -}}

{{- define "parabol.postgres-storage" -}}
  {{- printf "%s-postgres-data" (include "parabol.fullname" .) -}}
{{- end -}}

{{- define "parabol.redis-storage" -}}
  {{- printf "%s-redis-data" (include "parabol.fullname" .) -}}
{{- end -}}
