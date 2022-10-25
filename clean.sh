#!/usr/bin/env bash

K8S_CLI="kubectl"

error() { 
  echo "Error: invalid parameters!" >&2 
  usage >&2
  exit 1 
} 

usage() { 
  echo "Usage: ./clean.sh -n <NAMESPACE> -c <CRD>"
  echo "-n <NAMESPACE>: Kubernetes namespace" 
  echo "-c <CRD>: Kubernetes custom resource definition"
  echo "-h: Get the help"
} 

main() {
  "${K8S_CLI}" -n "${NS}" get "${CRD}" | while read name trash; do
    if [[ $name == "NAME" ]]; then
      continue
    fi

    echo "[main] deleting ${NS}/${CRD}/${name}"
    "${K8S_CLI}" -n "${NS}" get "${CRD}" "${name}" -o yaml | yq e ".metadata.finalizers = []" - | kubectl -n "${NS}" apply -f -
    "${K8S_CLI}" -n "${NS}" delete "${CRD}" "${name}" >/dev/null 2>&1 || :
  done
}

[[ $# -lt 1 ]] && error 

while getopts ":n:c:h" option; do 
    case "$option" in 
        n) NS="${OPTARG}" ;; 
        c) CRD="${OPTARG}" ;; 
        :) error ;;
        h) usage ;; 
        *) error ;; 
    esac 
done

main
