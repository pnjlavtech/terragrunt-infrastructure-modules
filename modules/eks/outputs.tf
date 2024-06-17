output "cluster_certificate_authority_data" {
  description = "The Kubernetes cluster certificate authority data (module.eks.cluster_ca_certificate)"
  value       = module.eks.cluster_ca_certificate
}

output "cluster_endpoint" {
  description = "Kubernetes cluster endpoint (module.eks.host)"
  value       = module.eks.host
}

output "cluster_name" {
  description = "Kubernetes cluster name"
  value       = module.eks.cluster_name
}

