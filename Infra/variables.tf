variable "prefix" {
    type = string
    description = "(optional) describe your variable"
}

variable "tags" {
    default = {
        environment ="dev"
        cost_centre ="5001",
        disaster_recovery = "criticle"
    }
}

variable "location" {
    type = string
    description = "location where your resource needs to provision in azure"
    default = "eastus"
}

variable "environment_name" {
    type = string
    description = "(optional) name of your environment"
}

variable "environment_instance" {
    type = string
    description = "(optional) name of your environment"
}

variable "project_name" {
    type = string
    description = "(optional) project name"
}

variable "company_name" {
    type = string
    description = "(optional) project name"
}


variable "account_tier" {
    type = string
    description = "(optional) describe your variable"
    default = "Standard"
}

variable "storages" {
   
    description = "(optional) all storage accounts"

    # default = {
    #             strassd01 = {
    #                 resource_group_name = "rg-bee-learn-eus-dev-01"
    #                 location = "eastus"
    #                 account_tier = "standard"

    #                 tags = {
    #                   application = "demo"
    #                   cost_centre = "asdf"
    #                   environment = "dev"
    #                 }
    #             },
    #             strassd02 = {
    #                 resource_group_name = "rg-bee-learn-eus-dev-01"
    #                 location = "eastus"
    #                 account_tier = "standard"

    #                 tags = {
    #                   application = "demo"
    #                   cost_centre = "asdf"
    #                   environment = "dev"
    #                 }
    #             },
    #             strassd03 = {
    #                 resource_group_name = "rg-bee-learn-eus-dev-01"
    #                 location = "eastus"
    #                 account_tier = "standard"

    #                 tags = {
    #                   application = "demo"
    #                   cost_centre = "asdf"
    #                   environment = "dev"
    #                 }
    #             }

    #     }
}