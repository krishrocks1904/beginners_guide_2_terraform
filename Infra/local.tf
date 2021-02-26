locals {

  
deployment = merge({
      storage_accounts      = {}
      key_vault             = {}
      cosmos_dbs            = {}
      application_insights  = {}
      log_analytics         = {}
      mssql_config          = {}
      postgresql            = {}
      messaging             = {}
      redis_cache           = {}
      
      api_management        = {}
      app_services          = {}
      data_factory         = {}
      
      container_regs        = {}
      aks_clusters          = {}

      network               = {}
      load_balancer          = {}

    }, var.deployment) 

management = merge({
        companyName = "com"
        service_name= "prj"
        environment_name= "ved"
        location = "ins"
        environment_instance= "01"
        tags     = {}},
       var.management)

}


