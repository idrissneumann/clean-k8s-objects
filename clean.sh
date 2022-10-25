#!/usr/bin/env bash

K8S_CLI="kubectl"
FILTER=""

error() { 
  echo "Error: invalid parameters!" >&2 
  usage >&2
  exit 1 
} 

usage() { 
  echo "Usage: ./clean.sh -n <NAMESPACE> -c <CRD>"
  echo "-n <NAMESPACE>: Kubernetes namespace" 
  echo "-c <CRD>: Kubernetes custom resource definition"
  echo "-f <FILTER>: Prefix filter (perform only on name begining with filter)"
  echo "-h: Get the help"
} 

main() {
  if [[ ! $NS ]] || [[ ! $CRD ]]; then
    error
  fi

  "${K8S_CLI}" -n "${NS}" get "${CRD}" | while read name trash; do
    if [[ $name == "NAME" ]] || [[ ! $name =~ "${FILTER}".* ]]; then
      continue
    fi

    echo "[main] deleting ${NS}/${CRD}/${name}"
    "${K8S_CLI}" -n "${NS}" get "${CRD}" "${name}" -o yaml | yq e ".metadata.finalizers = []" - | kubectl -n "${NS}" apply -f -
    "${K8S_CLI}" -n "${NS}" delete "${CRD}" "${name}" >/dev/null 2>&1 || :
  done
}

[[ $# -lt 1 ]] && error 

while getopts ":n:c:f:h" option; do 
    case "$option" in 
        n) NS="${OPTARG}" ;; 
        c) CRD="${OPTARG}" ;; 
        f) FILTER="${OPTARG}" ;;
        :) error ;;
        h) usage ;; 
        *) error ;; 
    esac 
done

main
