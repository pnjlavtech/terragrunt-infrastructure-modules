variable "argocd_chart_version" {
  description = "ArgoCD Helm Chart Version"
  type        = string

  default = "7.1.4"
}

variable "argocd_helm_settings" {
  description = "Additional settings for ArgoCD Helm deployment"
  type        = any

  default = {
    server = {
      extraArgs = ["--insecure"]
    }
  }
}

variable "cluster_certificate_authority_data" {
  description = "Kubernetes cluster certificate authority data (module.eks.cluster_ca_certificate)"
  type        = string
}

variable "cluster_endpoint" {
  description = "Kubernetes cluster endpoint (module.eks.host)"
  type        = string
}

variable "cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
}

variable "public_domain" {
  description = "Public DNS zone name"
  type        = string

  default = "pnjlavtech.com"
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)

  default = {
    module = "argocd"
  }
}