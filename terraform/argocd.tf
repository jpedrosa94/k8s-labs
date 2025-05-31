resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.8.2"
  # Templating gives the freedom to deploy multi-argo if needed
  values = [templatefile("./helm-values/argocd_values.yaml", {})]
}

# Self-reference to ArgoCD on first deployment
resource "helm_release" "argocd-apps" {
  name             = "argocd-apps"
  namespace        = "argocd"
  create_namespace = true
  chart      = "../charts/argocd-apps"

  depends_on = [helm_release.argocd]
}