if [ $# -lt 1 ]; then
    echo "No overlay specified, please specify an overlay from bootstrap/overlays"
    exit 1
else
    OVERLAY=$1
    echo "Configuring cluster ${OVERLAY}"
fi
kustomize build bootstrap/argocd/applicationset/overlays/${OVERLAY} | oc apply -f -