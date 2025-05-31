output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_connect" {
  value = "aws eks --region ${local.region} update-kubeconfig --name ${module.eks.cluster_name} --alias ${local.name}"
}
