{{/*
Expand the name of the chart.
*/}}
{{- define "biblioteca.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "biblioteca.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "biblioteca.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create image name that is used in the deployment
*/}}
{{- define "biblioteca.image" -}}
{{- if .Values.image.tag -}}
{{- printf "%s:%s" .Values.image.repository .Values.image.tag -}}
{{- else -}}
{{- printf "%s:%s" .Values.image.repository .Chart.AppVersion -}}
{{- end -}}
{{- end -}}


{{- define "biblioteca.ingress.apiVersion" -}}
{{- if semverCompare "<1.14-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "<1.19-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end }}
{{- end -}}


{{/*
Create environment variables used to configure the biblioteca container.
*/}}

{{- define "biblioteca.env" -}}
- name: DATABASE_URL
{{- if .Values.mariadb.enabled }}
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-db" .Release.Name }}
      key: url
{{- else }}
  {{- if .Values.externalDatabase.existingSecret.enabled }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.externalDatabase.existingSecret.secretName | default (printf "%s-db" .Release.Name) }}
      key: {{ .Values.externalDatabase.existingSecret.urlKey | default "url" }}
  {{- else }}
  value: {{ .Values.externalDatabase.url | quote }}
  {{- end }}
{{- end }}
- name: APP_ENV
  value: prod
- name: APP_SECRET
  {{- if .Values.biblioteca.appSecret.existingSecret.enabled }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.biblioteca.appSecret.existingSecret.secretName | default (printf "%s-appsecret" .Release.Name) }}
      key: {{ .Values.biblioteca.appSecret.existingSecret.urlKey | default "app-secret" }}
  {{- else }}
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-appsecret" .Release.Name }}
      key: "app-secret"
  {{- end }}
- name: MESSENGER_TRANSPORT_DSN
  value: {{ .Values.biblioteca.messengerTransportDSN | quote }}
- name: MAILER_DSN
  value: {{ .Values.biblioteca.mailerDSN | quote }}
- name: BOOK_FOLDER_NAMING_FORMAT
  value: {{ .Values.biblioteca.bookFolderNamingFormat | quote }}
- name: BOOK_FILE_NAMING_FORMAT
  value: {{ .Values.biblioteca.bookFileNamingFormat | quote }}
{{- if .Values.biblioteca.openai.apiKey }}
- name: OPEN_AI_API_KEY
  value: {{ .Values.biblioteca.openai.apiKey }}
- name: OPEN_AI_MODEL
  value: {{ .Values.biblioteca.openai.model }}
{{- end }}
{{- if .Values.biblioteca.ollama.url }}
- name: OLLAMA_URL
  value: {{ .Values.biblioteca.ollama.url }}
- name: OLLAMA_MODEL
  value: {{ .Values.biblioteca.ollama.model }}
{{- end }}
- name: KOBO_PROXY_USE_DEV
  value: "{{ if .Values.biblioteca.kobo.proxyUseDev }}1{{- else }}0{{- end }}"
- name: KOBO_PROXY_USE_EVERYWHERE
  value: "{{ if .Values.biblioteca.kobo.proxyUseEverywhere }}1{{- else }}0{{- end }}"
- name: KOBO_PROXY_ENABLED
  value: "{{ if .Values.biblioteca.kobo.proxyEnabled }}1{{- else }}0{{- end }}"
- name: ALLOW_BOOK_RELOCATION
  value: "{{ if .Values.biblioteca.allowBookRelocation }}1{{- else }}0{{- end }}"
{{- if .Values.typesense.enabled }}
- name: TYPESENSE_URL
  value: {{ printf "http://%s-typesense:%s" (include "biblioteca.fullname" .) .Values.typesense.containerPort }}
- name: TYPESENSE_KEY
  valueFrom:
    secretKeyRef:
    {{- if .Values.typesense.apiKeySecret.existingSecret.enabled }}
      name: {{ .Values.typesense.apiKeySecret.existingSecret.secretName }}
      key: {{ .Values.typesense.apiKeySecret.existingSecret.apiKeyKey }}
    {{- else }}
      name: {{ printf "%s-typesense-apikey" (include "biblioteca.fullname" .) }}
      key: "api-key"
    {{- end }}
{{- end }}
{{- if .Values.externalTypesense.enabled }}
- name: TYPESENSE_URL
  value: {{ .Values.externalTypesense.url }}
- name: TYPESENSE_KEY
  valueFrom:
    secretKeyRef:
    {{- if .Values.externalTypesense.existingSecret.enabled }}
      name: {{ .Values.externalTypesense.existingSecret.secretName }}
      key: {{ .Values.externalTypesense.existingSecret.apiKeyKey }}
    {{- else }}
      name: {{ printf "%s-typesense-apikey" (include "biblioteca.fullname" .) }}
      key: "api-key"
    {{- end }}
{{- end }}
{{- if .Values.pod.extraEnv }}
{{ toYaml .Values.pod.extraEnv }}
{{- end }}
{{- end -}}


{{/*
Create volume mounts for the biblioteca container.
*/}}
{{- define "biblioteca.volumeMounts" -}}
- name: biblioteca-books
  mountPath: /var/www/html/public/books
- name: biblioteca-covers-tmp
  mountPath: /var/www/html/public/covers
- name: biblioteca-media-tmp
  mountPath: /var/www/html/public/media
{{- if .Values.pod.extraVolumeMounts }}
{{ toYaml .Values.pod.extraVolumeMounts }}
{{- end }}
{{- end -}}
