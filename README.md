# Beginners guide 2 terraform


Terraform azure provider

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs


Terraform remote state backed azure

https://www.terraform.io/docs/language/settings/backends/azurerm.html

Terraform azure function

https://www.terraform.io/docs/language/functions/index.html

To run you code

Navigate to your terraform code directory

Run

   terraform init

  terraform plan

   If you want to passparamter to your code use 
     
  terraform plan -var=“name_of_variable=value” -var=“second_var=value_2”

  You can also pass parameter as json of tfvar file

  terraform plan -var-file=“../../path_to_your_variable_file” 

   You can combine both of them
   
  terraform plan -var-file=“../../path_to_your_variable_file” -var=“name_of_variable=value” 
