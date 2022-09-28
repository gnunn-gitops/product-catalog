if [ $# -lt 1 ]; then
    echo "No overlay specified, please specify an overlay from bootstrap/overlays"
    exit 1
else
    OVERLAY=$1
    echo "Deploying product catalog to cluster ${OVERLAY}"
fi
kustomize build bootstrap/argocd/apps/overlays/${OVERLAY} --enable-helm | oc apply -f -