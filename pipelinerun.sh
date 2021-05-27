if [ $# -lt 1 ]; then
    echo "No cluster name specified, please specify a cluster "
    exit 1
else
    CLUSTER=$1
    echo "Running pipelines for cluster: ${CLUSTER}"
fi
kustomize build clusters/${CLUSTER}/overlays/pipelinerun | oc apply -f -