#!/usr/bin/env bash

NS="mongodb-operator"
CRD="perconaservermongodbbackups.psmdb.percona.com"
K8S_CLI="kubectl"

"${K8S_CLI}" -n "${NS}" get "${CRD}" | while read name trash; do
  echo "Deleting ${name}"
  "${K8S_CLI}" -n "${NS}" get "${CRD}" "${name}" -o yaml | yq e ".metadata.finalizers = []" | kubectl -n "${NS}" apply -f -
  "${K8S_CLI}" -n "${NS}" delete "${CRD}" "${name}" >/dev/null 2>&1 || :
done
