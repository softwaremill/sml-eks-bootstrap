module "ebs_csi_irsa_role" {
  source                = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version               = "5.24.0"
  role_name             = "${var.eks_cluster_name}-ebs-csi-${var.region}"
  attach_ebs_csi_policy = true
  oidc_providers = {
    eks = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
  tags  = local.tags
  count = var.enable_ebs_csi_driver ? 1 : 0
}
