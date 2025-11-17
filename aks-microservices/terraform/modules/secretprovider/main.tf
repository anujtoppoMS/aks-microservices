provider "helm" {
  kubernetes = {
    host                   = var.host
    client_certificate     = base64decode(var.client_certificate)
    client_key             = base64decode(var.client_key)
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
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

resource "kubernetes_manifest" "secret_provider_class" {
  manifest = {
    apiVersion = "secrets-store.csi.x-k8s.io/v1"
    kind       = "SecretProviderClass"
    metadata = {
      name      = "azure-kv-secrets"
      namespace = "default"
    }
    spec = {
      provider   = "azure"
      parameters = {
        useWorkloadIdentity = "true"
        keyvaultName        = "my-keyvault"
        tenantId            = var.azure_tenant_id
        clientId            = var.aks_uai_client_id
        objects             = <<EOT
array:
  - |
    objectName: django-secret-key
    objectType: secret
  - |
    objectName: allowed_hosts
    objectType: secret
EOT
      }
    }
  }
}