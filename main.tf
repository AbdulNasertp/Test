# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "monitoring-resources"
  location = "East US"
}

resource "azurerm_monitor_action_group" "monitor-action-grp" {
  name                = "CriticalAlertsAction"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "serviceissue" 

  arm_role_receiver {
    name                    = "armroleaction"
    role_id                 = "43d0d8ad-25c7-4714-9337-8ba259a9fe05"    
  } 

  email_receiver {
    name          = "sendtoadmin"
    email_address = "anstpdev@gmail.com"
  } 

  email_receiver {
    name          = "sendtoadmin2"
    email_address = "anstpdev@outlook.com"
  } 
 
}

resource "azurerm_template_deployment" "main5" {
      name                = "MyApp-ARM-test-naser"
      resource_group_name = azurerm_resource_group.main.name
      
      template_body = file("arm/azuredeploy.json")

      deployment_mode = "Incremental"
}