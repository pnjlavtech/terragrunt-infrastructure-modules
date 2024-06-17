provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}


terraform {
  required_version = ">= 1.5.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.13.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.29.0"
    }
  }
}

locals {
  argocd_domain_name = "${local.kubernetes_namespace}.${var.public_domain}"

  kubernetes_namespace = "argocd"
}

resource "aws_acm_certificate" "argo" {
  domain_name       = local.argocd_domain_name
  validation_method = "DNS"

  tags = merge(var.tags, {
    Name = local.argocd_domain_name
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "argo_verify" {
  for_each = {
    for dvo in aws_acm_certificate.argo.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.this.zone_id
}

resource "helm_release" "argocd" {
  name       = "argo-cd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = var.argocd_chart_version
  namespace  = local.kubernetes_namespace

  set {
    name  = "installCRDs"
    value = true
  }

  values = [yamlencode(var.argocd_helm_settings)]

  depends_on = [kubernetes_namespace.argocd]
}

resource "kubernetes_namespace" "argocd" {
  metadata { name = local.kubernetes_namespace }

  # depends_on = [module.eks]
}