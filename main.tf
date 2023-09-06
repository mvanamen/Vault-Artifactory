
##########################################################################
#kubernetes cluster VAULT#                                        
##########################################################################


resource "azurerm_resource_group" "hashicorp_vault_xsec_resource_group" {
  name     = local.vault_resource_group_name
  location = local.location
}


resource "azurerm_kubernetes_cluster" "hashicorp_vault_xsec_kubernetes_cluster" {
  # checkov:skip=CKV_AZURE_4: For POC reason, skipping checkov policy
  # checkov:skip=CKV_AZURE_5: For POC reason, skipping checkov policy
  # checkov:skip=CKV_AZURE_7: For POC reason, skipping checkov policy
  # checkov:skip=CKV_AZURE_116: For POC reason, skipping checkov policy
  # checkov:skip=CKV_AZURE_117: For POC reason, skipping checkov policy
  name                = local.vaultcluster_name
  location            = azurerm_resource_group.hashicorp_vault_xsec_resource_group.location
  resource_group_name = azurerm_resource_group.hashicorp_vault_xsec_resource_group.name
  dns_prefix          = local.vaultcluster_dns_prefix

  default_node_pool {
    name       = "default"
    node_count = local.vaultcluster_node_count
    vm_size    = local.vaultcluster_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
  private_cluster_enabled = true
  local_account_disabled  = true
}




resource "local_file" "client_certificate" {
  content  = azurerm_kubernetes_cluster.hashicorp_vault_xsec_kubernetes_cluster.kube_config.0.client_certificate
  filename = local.vault_client_certificate_file
}

resource "local_file" "kube_config" {
  content  = azurerm_kubernetes_cluster.hashicorp_vault_xsec_kubernetes_cluster.kube_config_raw
  filename = local.vault_kube_config_file
}


# #########################################################################
# #local executions#
# #########################################################################


# resource "null_resource" "run_command1" {

#   provisioner "local-exec" {

#     command     = local.run_command1
#     interpreter = local.interpreterpowershell
#   }
# }

# resource "null_resource" "run_command2" {

#   provisioner "local-exec" {

#     command     = local.run_command2
#     interpreter = local.interpreterpowershell
#   }
# }

# resource "null_resource" "run_command3" {

#   provisioner "local-exec" {

#     command     = local.run_command3
#     interpreter = local.interpreterpowershell
#   }
# }


# ##########################################################################
# #helm#                                        
# ##########################################################################


# resource "helm_release" "hashicorp_vault_xsec_vault" {
#   name  = local.helm_vault_name
#   chart = local.helm_vault_chart
#   values = [
#     local.helm_vault_values_file
#   ]
#   set {
#     name  = local.helm_set_value_ui
#     value = local.helm_set_true
#   }
#   set {
#     name  = local.helm_set_value_serviceType
#     value = local.helm_set_loadbalancer
#   }
#   # metadata {
#   #   namespace = "xsec-vault"
#   # }
# }
