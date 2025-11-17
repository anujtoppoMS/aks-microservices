provider "helm" {
  alias = "aks"
}

resource "helm_release" "csi_driver" {
  name       = "csi-secrets-store"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"
  version    = "1.4.0" # pin a stable version
  namespace  = "kube-system"
}

resource "helm_release" "akv_provider" {
  name       = "csi-azure-provider"
  repository = "https://azure.github.io/secrets-store-csi-driver-provider-azure/charts"
  chart      = "csi-secrets-store-provider-azure"
  version    = "1.4.0"
  namespace  = "kube-system"
}