locals {
  #Vault Locals
  vault_resource_group_name     = "Vault_Xsec"
  location                      = "westeurope"
  vaultcluster_name             = "Xsec"
  vaultcluster_dns_prefix       = "xsecvaultaks1"
  vaultcluster_vm_size          = "Standard_D2_v2"
  vaultcluster_node_count       = 1
  vault_client_certificate_file = "client_certificate_key.pem"
  vault_kube_config_file        = "kube.config"

  #Custom run commands
  interpreterpowershell = ["PowerShell", "-Command"]
  run_command1          = "$KUBECONFIG = \"C:/Users/MaikelvanAmen/Secret Management POC/kube.config\""
  run_command2          = "kubectl create namespace xsec-vault"
  run_command3          = "kubectl config set-context --current --namespace=xsec-vault"

  #Helm Locals
  helm_vault_name            = "hcvault"
  helm_vault_chart           = "https://github.com/hashicorp/vault-helm/archive/v0.22.1.tar.gz"
  helm_vault_values_file     = file("values.yaml")
  helm_set_value_ui          = "ui.enabled"
  helm_set_value_serviceType = "ui.serviceType"
  helm_set_true              = "true"
  helm_set_loadbalancer      = "LoadBalancer"
}
