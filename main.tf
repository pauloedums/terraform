terraform {
    required_version = ">= 0.14.9"

    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = ">= 2.26"
        }
    }
}

provider "azurerm" {
    skip_provider_registration = true
    features {}
}

resource "azurerm_resource_group" "rg_terraform_desafio" {
    name     = "terraform"
    location = var.location

    tags = {
        environment = "aula infra"
    }
}