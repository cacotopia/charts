{{/* vim: set filetype=mustache: */}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kube-eventer.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create default config for leader election when replicaCount is greater than 1
*/}}
{{- define "kube-eventer.leaderElectionConfig" -}}
  {{- if gt (int64 .Values.replicaCount) 1 -}}
leaderElection:
  enabled: true
  leaderElectionID: {{ include "common.names.fullname" . }}-leader-election
  {{- else -}}
leaderElection: {}
  {{- end -}}
{{- end -}}

{{/*
Create final config by merging user supplied config and default config
*/}}
{{- define "kube-eventer.config" -}}
  {{- $leaderElectionConfig := fromYaml (include "kube-eventer.leaderElectionConfig" .) -}}
  {{- toYaml (mergeOverwrite $leaderElectionConfig .Values.config) }}
{{- end -}}

{{/*
Return the proper dingtalk sink url
{{ include "kube-eventer.sink.dingtalk" }}
*/}}
{{- define "kube-eventer.sink.dingtalk" -}}
{{- if .Values.sink.dingtalk.enabled -}}
{{- $dingtalkUrl := "https://oapi.dingtalk.com/robot/send" -}}
{{- $urlParams := "" -}}
{{- if .Values.sink.dingtalk.access_token }}
{{- $urlParams = printf "access_token=%s" .Values.sink.dingtalk.access_token -}}
{{- end -}}
{{- if .Values.sink.dingtalk.label }}
{{- if $urlParams }}
{{- $urlParams = printf "%s&label=%s" $urlParams .Values.sink.dingtalk.label -}}
{{- else -}}
{{-  $urlParams = printf "label=%s" .Values.sink.dingtalk.label -}}
{{- end -}}
{{- end -}}
{{- if .Values.sink.dingtalk.level -}}
{{- if $urlParams -}}
{{-  $urlParams = printf "%s&level=%s" $urlParams .Values.sink.dingtalk.level -}}
{{- else -}}
{{-  $urlParams = printf "level=%s" .Values.sink.dingtalk.level -}}
{{- end -}}
{{- end -}}

{{- if .Values.sink.dingtalk.namespaces -}}
{{- if $urlParams -}}
{{-  $urlParams = printf "%s&namespaces=%s" $urlParams .Values.sink.dingtalk.namespaces -}}
{{- else -}}
{{-  $urlParams = printf "namespaces=%s" .Values.sink.dingtalk.namespaces -}}
{{- end -}}
{{- end -}}

{{- if .Values.sink.dingtalk.kinds -}}
{{- if $urlParams -}}
{{-  $urlParams = printf "%s&kinds=%s" $urlParams .Values.sink.dingtalk.kinds -}}
{{- else -}}
{{-  $urlParams = printf "kinds=%s" .Values.sink.dingtalk.kinds -}}
{{- end -}}
{{- end -}}

{{- if .Values.sink.dingtalk.msg_type -}}
{{- if $urlParams -}}
{{-  $urlParams = printf "%s&msg_type=%s" $urlParams .Values.sink.dingtalk.msg_type -}}
{{- else -}}
{{-  $urlParams = printf "msg_type=%s" .Values.sink.dingtalk.msg_type -}}
{{- end -}}
{{- end -}}

{{- if .Values.sink.dingtalk.sign -}}
{{- if $urlParams -}}
{{-  $urlParams = printf "%s&sign=%s" $urlParams .Values.sink.dingtalk.sign -}}
{{- else -}}
{{-  $urlParams = printf "sign=%s" .Values.sink.dingtalk.sign -}}
{{- end -}}
{{- end -}}

{{- if .Values.sink.dingtalk.cluster_id -}}
{{- if $urlParams -}}
{{-  $urlParams = printf "%s&cluster_id=%s" $urlParams .Values.sink.dingtalk.cluster_id -}}
{{- else -}}
{{-  $urlParams = printf "cluster_id=%s" .Values.sink.dingtalk.cluster_id -}}
{{- end -}}
{{- end -}}
{{- if .Values.sink.dingtalk.region -}}
{{- if $urlParams -}}
{{-  $urlParams = printf "%s&region=%s" $urlParams .Values.sink.dingtalk.region -}}
{{- else -}}
{{-  $urlParams = printf "region=%s" .Values.sink.dingtalk.region -}}
{{- end -}}
{{- end -}}
{{- printf "--sink=dingtalk:%s?%s" $dingtalkUrl $urlParams -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper wechat sink url
{{ include "kube-eventer.sink.wechat" }}
*/}}
{{- define "kube-eventer.sink.wechat" -}}
{{- if .Values.sink.wechat.enabled -}}
{{- $urlParams := "" -}}
{{- if .Values.sink.wechat.corp_id }}
{{- $urlParams = printf "corp_id=%s" .Values.sink.wechat.corp_id -}}
{{- end -}}
{{- if .Values.sink.wechat.corp_secret }}
{{- if $urlParams }}
{{- $urlParams = printf "%s&corp_secret=%s" $urlParams .Values.sink.wechat.corp_secret -}}
{{- else -}}
{{-  $urlParams = printf "corp_secret=%s" .Values.sink.wechat.corp_secret -}}
{{- end -}}
{{- end -}}
{{- if .Values.sink.wechat.agent_id }}
{{- if $urlParams }}
{{- $urlParams = printf "%s&agent_id=%s" $urlParams .Values.sink.wechat.agent_id -}}
{{- else -}}
{{-  $urlParams = printf "agent_id=%s" .Values.sink.wechat.agent_id -}}
{{- end -}}
{{- end -}}
{{- if .Values.sink.wechat.to_user }}
{{- if $urlParams }}
{{- $urlParams = printf "%s&to_user=%s" $urlParams .Values.sink.wechat.to_user -}}
{{- else -}}
{{-  $urlParams = printf "to_user=%s" .Values.sink.wechat.to_user -}}
{{- end -}}
{{- end -}}
{{- if .Values.sink.wechat.label }}
{{- if $urlParams }}
{{- $urlParams = printf "%s&label=%s" $urlParams .Values.sink.wechat.label -}}
{{- else -}}
{{-  $urlParams = printf "label=%s" .Values.sink.wechat.label -}}
{{- end -}}
{{- end -}}
{{- if .Values.sink.wechat.level }}
{{- if $urlParams }}
{{- $urlParams = printf "%s&level=%s" $urlParams .Values.sink.wechat.level -}}
{{- else -}}
{{-  $urlParams = printf "level=%s" .Values.sink.wechat.level -}}
{{- end -}}
{{- end -}}
{{- if .Values.sink.wechat.namespaces }}
{{- if $urlParams }}
{{- $urlParams = printf "%s&namespaces=%s" $urlParams .Values.sink.wechat.namespaces -}}
{{- else -}}
{{-  $urlParams = printf "namespaces=%s" .Values.sink.wechat.namespaces -}}
{{- end -}}
{{- end -}}
{{- if .Values.sink.wechat.kinds }}
{{- if $urlParams }}
{{- $urlParams = printf "%s&kinds=%s" $urlParams .Values.sink.wechat.kinds -}}
{{- else -}}
{{-  $urlParams = printf "kinds=%s" .Values.sink.wechat.kinds -}}
{{- end -}}
{{- end -}}
{{- printf "--sink=wechat:?%s" $urlParams -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper sls sink url
{{ include "kube-eventer.sink.sls" }}
*/}}
{{- define "kube-eventer.sink.sls" -}}
{{- if .Values.sink.sls.enabled -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper webhook sink url
{{ include "kube-eventer.sink.webhook" }}
*/}}
{{- define "kube-eventer.sink.webhook" -}}
{{- if .Values.sink.webhook.enabled -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper elasticsearch sink url
{{ include "kube-eventer.sink.elasticsearch" }}
*/}}
{{- define "kube-eventer.sink.elasticsearch" -}}
{{- if .Values.sink.elasticsearch.enabled -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper honeycomb sink url
{{ include "kube-eventer.sink.honeycomb" }}
*/}}
{{- define "kube-eventer.sink.honeycomb" -}}
{{- if .Values.sink.honeycomb.enabled -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper riemann sink url
{{ include "kube-eventer.sink.riemann" }}
*/}}
{{- define "kube-eventer.sink.riemann" -}}
{{- if .Values.sink.riemann.enabled -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper kafka sink url
{{ include "kube-eventer.sink.kafka" }}
*/}}
{{- define "kube-eventer.sink.kafka" -}}
{{- if .Values.sink.kafka.enabled -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper mysql sink url
{{ include "kube-eventer.sink.mysql" }}
*/}}
{{- define "kube-eventer.sink.mysql" -}}
{{- if .Values.sink.mysql.enabled -}}
{{- $urlParams := "" -}}
{{-  $urlParams = printf "%s:%s@tcp(%s:%s)/%s" .Values.sink.mysql.username .Values.sink.mysql.password .Values.sink.mysql.serverHost .Values.sink.mysql.serverPort .Values.sink.mysql.database -}}
{{- if .Values.sink.mysql.urlParams }}
{{- printf "--sink=mysql:?%s?%s" $urlParams .Values.sink.mysql.urlParams -}}
{{- else -}}
{{- printf "--sink=mysql:?%s" $urlParams -}}
{{- end -}}
{{- end -}}
{{- end -}}

## @param sinks.mysql sink to mysql database configuration parameter
## @param sinks.mysql.serverHost
## @param sinks.mysql.serverPort 
## @param sinks.mysql.username  mysql username (default: `root`)
## @param sinks.mysql.password  mysql password (default: `root`)
## @param sinks.mysql.database  mysql Database name (default: `k8s`)
## @param sinks.mysql.urlParams  mysql Database name (default: `k8s`)

{{/*
Return the proper influxdb sink url
{{ include "kube-eventer.sink.influxdb" }}
*/}}
{{- define "kube-eventer.sink.influxdb" -}}
{{- if .Values.sink.influxdb.influxdb -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper mongodb sink url
{{ include "kube-eventer.sink.mongodb" }}
*/}}
{{- define "kube-eventer.sink.mongodb" -}}
{{- if .Values.sink.mongodb.mongodb -}}
{{- end -}}
{{- end -}}
